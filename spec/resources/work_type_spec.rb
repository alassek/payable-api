require 'spec_helper'

RSpec.describe Payable::WorkType, vcr: { cassette_name: 'work_type' } do
  let(:unit){ Payable::WorkType.retrieve(123) }
  let(:time){ Payable::WorkType.retrieve(234) }
  let(:money){ Payable::WorkType.retrieve(345) }
  let(:dist){ Payable::WorkType.retrieve(456) }

  specify "unit WorkType" do
    expect{ unit }.to_not raise_error

    expect(unit.id).to eq 123
    expect(unit.name).to eq "Test WorkType by units"
    expect(unit.quantity_measure).to eq "unit"
    expect(unit.created_at).to eq DateTime.new(2016, 10, 28, 17, 45, 11)
    expect(unit.updated_at).to eq DateTime.new(2016, 10, 31, 20, 55, 34)
  end

  specify "time WorkType" do
    expect{ time }.to_not raise_error

    expect(time.id).to eq 234
    expect(time.name).to eq "Test WorkType by time"
    expect(time.quantity_measure).to eq "time"
    expect(time.created_at).to eq DateTime.new(2016, 10, 28, 17, 45, 11)
    expect(time.updated_at).to eq DateTime.new(2016, 10, 31, 20, 55, 34)
  end

  specify "money WorkType" do
    expect{ money }.to_not raise_error

    expect(money.id).to eq 345
    expect(money.name).to eq "Test WorkType by money"
    expect(money.quantity_measure).to eq "money"
    expect(money.created_at).to eq DateTime.new(2016, 10, 28, 17, 45, 11)
    expect(money.updated_at).to eq DateTime.new(2016, 10, 31, 20, 55, 34)
  end

  specify "distance WorkType" do
    expect{ dist }.to_not raise_error

    expect(dist.id).to eq 456
    expect(dist.name).to eq "Test WorkType by distance"
    expect(dist.quantity_measure).to eq "distance"
    expect(dist.created_at).to eq DateTime.new(2016, 10, 28, 17, 45, 11)
    expect(dist.updated_at).to eq DateTime.new(2016, 10, 31, 20, 55, 34)
  end

  context "WorkType.list" do
    context "default page size (50)" do
      subject { Payable::WorkType.list }

      specify "#to_a returns all records" do
        expect(subject.to_a).to match_array [unit, time, money, dist]
      end
    end

    context "page size: 2" do
      subject { Payable::WorkType.list(page_size: 2) }

      it "#to_a returns all records" do
        expect(subject.to_a).to match_array [unit, time, money, dist]
      end

      specify "#page returns the individual pages of records" do
        expect(subject.page(1)).to match_array [unit, time]
        expect(subject.page(2)).to match_array [money, dist]
        expect(subject.page(3)).to match_array []
      end

      specify "#[] accesses all pages transparently" do
        expect(subject[0]).to eq unit
        expect(subject[3]).to eq dist
        expect(subject[-2]).to eq money
      end
    end
  end
end
