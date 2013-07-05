require 'spec_helper'

describe UsersController do
  let!( :user ) { create( :user ) }
  subject { user }

  describe "GET #index" do
    it "populates an array of Users" do
      get :index, format: :json
      expect( assigns( :users ) ).to match_array( [user] )
    end

    it "renders the index.json.rabl" do
      get :index, format: :json
      expect( response ).to render_template :index
    end

    it "responds with a 200 OK status code" do
      get :index, format: :json
      expect( response.response_code ).to eq 200
    end
  end

  describe "GET #show" do

    context "with an existing user" do
      it "assigns the requested user to @user" do
        get :show, id: user.id, format: :json
        expect( assigns(:user) ).to eq user
      end

      it "renders the show.json.rabl template" do
        get :show, id: user.id, format: :json
        expect( response ).to render_template :show
      end

      it "responds with a 200 OK status code" do
        get :show, id: user.id, format: :json
        expect( response.response_code ).to eq 200
      end
    end
    
    context "with a non-existent user" do
      it "responds with a 404 Not Found status code" do
        get :show, id: "-1", format: :json
        expect( response.response_code ).to eq 404
      end
    end

  end

end