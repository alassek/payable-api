require 'spec_helper'

RSpec.describe Payable::Resource do
  subject { Payable::Resource }

  it "requires an id attribute" do
    expect{ subject.new }.to raise_error(TypeError)
    expect{ subject.new(id: 420) }.to_not raise_error
  end

  it "is an abstract class" do
    expect{ subject.url_template }.to raise_error(NotImplementedError)
    expect{ subject.retrieve(420) }.to raise_error(NotImplementedError)
  end
end
