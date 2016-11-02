module Payable
  class ResourceList
    include Enumerable

    attr_reader :type, :collection, :resource_url, :page_size, :pages, :params

    def initialize(type, options = {})
      @type = case type
      when Symbol, String then Payable.const_get(type)
      else type
      end

      @collection   = @type.collection
      @resource_url = Payable.api_url.join(collection)
      @client       = options.delete(:client){ Payable.client }
      @page_num     = options.delete(:page_num){ 1 }
      @page_size    = options.delete(:page_size){ Payable.config.page_size }
      @page_size    = 50 if @page_size < 1
      @page_size    = 250 if @page_size > 250
      @params       = options
      @pages        = {}
    end

    alias :all :to_a

    def [](index)
      index = (length + index) if index < 0
      page_num, offset = index.divmod(page_size)
      page(page_num + 1)[offset]
    end

    def page(num)
      @pages[num] ||= begin
        response = get(page: num)
        @total_count = response.body[:total_count]
        map response.body[collection.to_sym]
      end
    end

    def total_count
      @total_count ||= begin
        get(page_size: 1).body[:total_count]
      end
    end

    alias :length :total_count

    def each
      return to_enum(__callee__) unless block_given?

      0.step.each do |index|
        item = self[index] or break
        yield item
      end
    end

    private

    attr_reader :client

    def get(page: 1, page_size: @page_size)
      client.get(resource_url, params.merge(page: page, page_size: page_size))
    end

    def map(collection)
      Array(collection).map{ |row| type.new(row) }
    end
  end
end
