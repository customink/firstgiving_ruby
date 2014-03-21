require 'spec_helper'

describe FirstGiving do

  APPLICATION_KEY = 'ADD YOUR APP KEY HERE'
  SECURITY_TOKEN  = 'ADD YOUR SECURITY TOKEN HERE'

  OPTIONS = {
    use_staging: true
  }

  FirstGiving.configure do |config|
    config.application_key = APPLICATION_KEY
    config.security_token  = SECURITY_TOKEN
    config.options = OPTIONS
  end

  @transaction_id = 'a-a8ca75adcda6874abd9c5b'

  describe 'Test Donation API' do

    it 'should donate' do
      params = {
        ccNumber: '4457010000000009',
        ccType: 'VI',
        ccExpDateMonth: '01',
        ccExpDateYear: '14',
        billToAddressLine1: '1 Main St.',
        billToCity: 'Burlington',
        billToState: 'MA',
        billToZip: '01803',
        remoteAddr: '120.138.91.2',
        amount: '10.00',
        currencyCode: 'USD',
        charityId: '1234',
        description: 'Test transaction',
        ccCardValidationNum: '349',
        billToFirstName: 'Smith',
        billToLastName: 'John',
        billToCountry: 'US',
        billToEmail: 'test@example.com'
      }

      response = FG.donation.creditcard(params)
      ## Response should success
      assert_acknowledgement(response)
      ## Response should contain transaction ID
      @transaction_id = response['firstGivingDonationApi']['firstGivingResponse']['transaction_id']
      @transaction_id.should_not be_nil
    end

    it 'should verify' do
      params = {
        message: 'value1',
        signature: 'value2'
      }

      response = FG.donation.verify(params)
      ## Response should return the same message and signature
      response['firstGivingDonationApi']['firstGivingResponse']['signature'] == 'value2'
      response['firstGivingDonationApi']['firstGivingResponse']['message'] == 'value1'
    end

    it 'shoould recure the payment' do
    end

  end

  describe 'Test Lookup API' do

    it 'should return a list of transactions' do
      params = {
        page_size: 10,
        date_from: '1388707200',
        count: 10,
        page: 1
      }
      resp = FG.lookup.list(params)
      assert_acknowledgement(resp)
    end

    it 'should return a transaction detail' do
      params = {
        transaction_id: 'a-0070dde28ca48048a1fc24'
      }
      resp = FG.lookup.detail(params)
      assert_acknowledgement(resp)
    end

  end

  context 'Test Search API' do

    describe 'retrieving a charity by EIN' do
      it 'should return data for charities' do
        params = {
          q: 'government_id:260046127'
        }

        response = FG.search.query(params)
        response.should_not be_nil
        response[0]['government_id'].should eq '260046127'
      end
    end

    describe 'searching for records by organization name' do
      it 'exact name matching and partial or name start' do
        params = {
          q: 'organization_name:humane society'
        }

        response = FG.search.query(params)
        response.should_not be_nil
        response[0]['organization_name'].should include 'HUMANE SOCIETY'
      end

      it 'country constraints' do
        params = {
          q: 'organization_name:bat AND country:US'
        }

        response = FG.search.query(params)
        response.should_not be_nil
        response[0]['organization_name'].should include 'BAT'
        response[0]['country'].should eq 'US'
      end

      it 'pagination' do
        params = {
          q: 'organization_name:bat AND country:US',
          page_size: '10',
          page: 1
        }

        response = FG.search.query(params)
        response.should_not be_nil
        response[0]['organization_name'].should include 'BAT'
        response[0]['country'].should eq 'US'
        response.count.should eq 10
      end
    end
  end

  private

  def assert_acknowledgement(response)
    response['firstGivingDonationApi']['firstGivingResponse']['acknowledgement'].should eq 'Success'
  end
end
