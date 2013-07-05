require 'spec_helper'

describe EventsController do
  let!( :event ) { create( :event ) }
  subject{ event }

  describe 'GET #index' do
    it 'populates an array of Events' do
      get :index, format: :json
      expect( assigns( :events ) ).to match_array( [event] )
    end

    it 'renders index.html.erb' do
      get :index, format: :html
      expect( response ).to render_template :index
    end

    it 'responds with a 200 OK status code' do
      get :index, format: :json
      expect( response.response_code ).to eq 200
    end
  end

  describe 'GET #show' do
    context 'existing event' do

      it 'assigns an event to @event' do
        get :show, id: event.id, format: :json
        expect( assigns( :event ) ).to eq event
      end

      it 'renders show.json.rabl' do
        get :show, id: event.id, format: :json
        expect( response ).to render_template :show
      end

      it 'responds with a 200 OK status code' do
        get :show, id: event.id, format: :json
        expect( response.response_code ).to eq 200
      end

    end

    context 'non-existent event' do
      it 'responds with 404 status code' do
        get :show, id: "-1", format: :json
        expect( response.response_code ).to eq 404
      end
    end
  end
end