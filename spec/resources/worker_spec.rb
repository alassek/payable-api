require 'spec_helper'

RSpec.describe Payable::Worker, vcr: { cassette_name: 'workers', match_requests_on: [:method, :path, :query, :body] } do
  let(:ricky){ Payable::Worker.retrieve(2913066854) }
  let(:cal){ Payable::Worker.retrieve(65139642) }
  let(:jean){ Payable::Worker.retrieve(5361496072) }

  specify "retrieve" do
    expect{ ricky }.to_not raise_error

    expect(ricky.id).to eq 2913066854
    expect(ricky.display_name).to eq "Ricky Bobby"
    expect(ricky.email).to eq "ricky.bobby@example.com"
  end

  context "create" do
    let :ricky do
      Payable::Worker.create(
        display_name: 'Ricky Bobby',
        first_name:   'Ricky',
        last_name:    'Bobby',
        email:        'ricky.bobby@example.com',
        invite:       false
      )
    end

    let :cal do
      Payable::Worker.create(
        first_name: 'Cal',
        last_name:  'Naughton',
        email:      'cal.naughton.jr@example.com'
      )
    end

    it "returns the created user" do
      expect{ ricky }.to_not raise_error

      expect(ricky.display_name).to eq "Ricky Bobby"
      expect(ricky.first_name).to eq "Ricky"
      expect(ricky.last_name).to eq "Bobby"
      expect(ricky.email).to eq "ricky.bobby@example.com"
      expect(ricky.invite_status).to eq 'not_invited'
    end

    it "requires display_name" do
      expect{ cal }.to raise_error(Payable::InvalidRequest)
    end
  end

  context "Worker.list" do
    include_examples "ResourceList", Payable::Worker

    context "page size: 1" do
      subject{ Payable::Worker.list(page_size: 1) }

      specify "#page returns the individual pages of records" do
        expect(subject.page(1)).to match_array [ricky]
        expect(subject.page(2)).to match_array [cal]
        expect(subject.page(3)).to match_array [jean]
      end
    end
  end
end
