require 'spec_helper'

RSpec.describe Payable::WorkType, vcr: { cassette_name: 'work_types', match_requests_on: [:method, :path, :query] } do
  let(:unit){ Payable::WorkType.retrieve(4167373472) }
  let(:time){ Payable::WorkType.retrieve(7413727327) }
  let(:money){ Payable::WorkType.retrieve(3147377972) }
  let(:dist){ Payable::WorkType.retrieve(6317677432) }

  specify "unit WorkType" do
    expect{ unit }.to_not raise_error

    expect(unit.id).to eq 4167373472
    expect(unit.name).to eq "Units"
    expect(unit.quantity_measure).to eq "unit"
    expect(unit.created_at).to be_a DateTime
    expect(unit.updated_at).to be_a DateTime
  end

  specify "time WorkType" do
    expect{ time }.to_not raise_error

    expect(time.id).to eq 7413727327
    expect(time.name).to eq "Hours"
    expect(time.quantity_measure).to eq "time"
    expect(time.created_at).to be_a DateTime
    expect(time.updated_at).to be_a DateTime
  end

  specify "money WorkType" do
    expect{ money }.to_not raise_error

    expect(money.id).to eq 3147377972
    expect(money.name).to eq "Expenses"
    expect(money.quantity_measure).to eq "money"
    expect(money.created_at).to be_a DateTime
    expect(money.updated_at).to be_a DateTime
  end

  specify "distance WorkType" do
    expect{ dist }.to_not raise_error

    expect(dist.id).to eq 6317677432
    expect(dist.name).to eq "Mileage"
    expect(dist.quantity_measure).to eq "distance"
    expect(dist.created_at).to be_a DateTime
    expect(dist.updated_at).to be_a DateTime
  end

  context "WorkType.list" do
    include_examples "ResourceList", Payable::WorkType

    context "page size: 2" do
      subject{ Payable::WorkType.list(page_size: 2) }

      specify "#page returns the individual pages of records" do
        expect(subject.page(1)).to match_array [time, money]
        expect(subject.page(2)).to match_array [dist, unit]
        expect(subject.page(3)).to match_array []
      end
    end
  end
end
