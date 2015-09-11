require 'rails_helper'

RSpec.describe '/cleaner/service/health', type: :request do
  describe 'GET /visible_messages' do
    it 'returns a 200 status code' do
      get '/cleaner/service/health/visible_messages'
      expect(response).to have_http_status 200
    end

    context 'when message queue limit exceeded' do
      before do
        allow_any_instance_of(Doctorable).to receive(:average_of_messages_visible).and_return(999)
      end

      it 'returns a 503 status code' do
        get '/cleaner/service/health/visible_messages'
        expect(response).to have_http_status 503
      end
    end
  end

  describe 'GET /processing_jobs' do
    it 'returns a 200 status code' do
      get '/cleaner/service/health/processing_jobs'
      expect(response).to have_http_status 200
    end

    context 'when message queue limit exceeded' do
      let!(:jobs) { create_list :job, 20, :processing }

      it 'returns a 503 status code' do
        get '/cleaner/service/health/processing_jobs'
        expect(response).to have_http_status 503
      end
    end
  end

  describe 'GET /collecting_jobs' do
    it 'returns a 200 status code' do
      get '/cleaner/service/health/collecting_jobs'
      expect(response).to have_http_status 200
    end

    context 'when message queue limit exceeded' do
      let!(:jobs) { create_list :job_progression, 10, :collecting }

      it 'returns a 503 status code' do
        get '/cleaner/service/health/collecting_jobs'
        expect(response).to have_http_status 503
      end
    end
  end

  describe 'GET /destroying_jobs' do
    it 'returns a 200 status code' do
      get '/cleaner/service/health/destroying_jobs'
      expect(response).to have_http_status 200
    end

    context 'when message queue limit exceeded' do
      let!(:jobs) { create_list :job_progression, 20, :destroying }

      it 'returns a 503 status code' do
        get '/cleaner/service/health/destroying_jobs'
        expect(response).to have_http_status 503
      end
    end
  end
end
