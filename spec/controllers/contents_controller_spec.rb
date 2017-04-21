require 'spec_helper'

RSpec.describe ContentsController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:content) { FactoryGirl.create(:content, user: user) }

  before do
    sign_in_as user
  end

  describe 'GET #index' do
    let(:user_2) { FactoryGirl.create :user }
    let(:user_3) { FactoryGirl.create :user }
    let!(:content_2) { FactoryGirl.create(:content, user: user_2) }
    let!(:content_3) { FactoryGirl.create(:content, user: user_3) }

    context 'get all contents when personal_posts false' do
      before do
        session[:personal_posts] = false
      end

      it 'get all contents' do
        get :index
        expect(assigns(:posts)).to match_array([content, content_2, content_3])
        session[:personal_posts] = nil
      end
    end

    context 'get only own contents when personal_posts true' do
      before do
        session[:personal_posts] = true
      end

      it 'get only own contents' do
        get :index
        expect(assigns(:posts)).to match_array([content])
        session[:personal_posts] = nil
      end
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested content to @content' do
      get :show, params: { id: content }
      expect(assigns(:content)).to eq content
    end

    it 'renders the :show template' do
      get :show, params: { id: content }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new content to @content' do
      get :new
      expect(assigns(:content)).to be_a_new(Content)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'content #create' do
    it 'saves the new content in the database' do
      content_attributes = FactoryGirl.attributes_for(:content)
      expect { post :create, params: { content: content_attributes } }.to change(Content, :count).from(0).to(1)
    end

    it 'redirects to content#index' do
      post :create, params: { content: FactoryGirl.attributes_for(:content, title: 'title', body: 'body') }
      expect(response).to redirect_to contents_url
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested country to @content' do
      get :edit, params: { id: content }
      expect(assigns(:content)).to eq content
    end

    it 'renders the :edit template' do
      get :edit, params: { id: content }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it "changes content's attributes" do
      put :update, params: { id: content , content: FactoryGirl.attributes_for(:content, title: 'title') }
      content.reload
      expect(content.title).to eq('title')
    end

    it 'redirects to the updated content' do
      put :update, params: { id: content , content: FactoryGirl.attributes_for(:content, title: 'title') }
      content.reload
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the content' do
      content.save
      expect { delete :destroy, params: { id: content } }.to change(Content, :count).by(-1)
    end

    it 'redirects to content#index' do
      delete :destroy, params: { id: content }
      expect(response).to redirect_to contents_url
    end
  end
end