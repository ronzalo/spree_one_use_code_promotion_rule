require 'spec_helper'

describe Spree::Promotion::Rules::OneUseCode do

  let(:rule) { Spree::Promotion::Rules::OneUseCode.new }

  let(:order) { mock_model Spree::Order }

  describe "#eligible?" do

    context "no email" do

      it "is not eligible if no email is supplied" do
        rule.stub email: false

        expect(rule).not_to be_eligible(order)
      end

    end

    context "no orders" do

      before(:each) do
        rule.stub email: "email@example.com"
        rule.stub orders_by_email: []
      end

      it "is eligible if there are no previous orders" do
        expect(rule).to be_eligible(order)
      end

    end

    context "no used codes" do

      before(:each) do
        rule.stub email: "email@example.com"
        rule.stub used_codes: []
        rule.stub orders_by_email: [order]
      end

      it "is eligible if there are no previous used codes" do
        expect(rule).to be_eligible(order)
      end

    end

    context "no similar used codes" do

      before(:each) do
        rule.stub email: "email@example.com"
        rule.stub used_codes: ["promotion"]
        rule.stub orders_by_email: [order]
      end

      it "is eligible if no matching codes" do
        rule.stub_chain :promotion, code: "nope"
        expect(rule).to be_eligible(order)
      end

      it "is not eligible if there are matching codes" do
        rule.stub_chain :promotion, code: "promotion"
        expect(rule).not_to be_eligible(order)
      end

    end

  end

end
