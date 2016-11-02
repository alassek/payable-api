RSpec.shared_examples "ResourceList" do |klass|
  let(:all_records){ klass.list.to_a }

  context "default page size (50)" do
    subject { klass.list }

    specify "#to_a returns all records" do
      expect(subject.to_a).to match_array all_records
    end
  end

  context "page size: 2" do
    subject { klass.list(page_size: 2) }

    it "#to_a returns all records" do
      expect(subject.to_a).to match_array all_records
    end

    specify "#[] accesses all pages transparently" do
      expect(subject[0]).to eq all_records[0]
      expect(subject[3]).to eq all_records[3]
      expect(subject[-2]).to eq all_records[-2]
    end
  end

  context "page size: 300" do
    subject { klass.list(page_size: 300) }

    it "maxes out at 250" do
      expect{ subject.page(1) }.to_not raise_error
      expect(subject.page_size).to eq 250
    end
  end

  context "page size: -1" do
    subject { klass.list(page_size: -1) }

    it "defaults to 50" do
      expect{ subject }.to_not raise_error
      expect(subject.page_size).to eq 50
    end
  end
end
