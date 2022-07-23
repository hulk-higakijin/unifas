require 'rails_helper'

RSpec.describe "Recruitments", type: :request do
  describe "GET #index" do
    it "ステータス200を返すこと" do
      get recruitments_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before do 
      @recruitment = create(:recruitment)
    end

    context "正常時" do
      it "ステータス200を返すこと" do
        get recruitment_path(@recruitment)
        expect(response).to have_http_status(200)
      end
    end

    context "募集が存在しないとき" do
      it "NotFoundエラーが出ること" do
        expect {
          get recruitment_path(Recruitment.last.id + 1)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #new" do
    context "未ログイン時" do
      it "ログインページにリダイレクトすること" do
        get new_recruitment_path
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがステータス：不明のとき" do
      it ""
    end

    context "ログインアカウントがステータス：受験生のとき" do
      before do
        @account = create(:candidate_account)
        @account.create_candidate(name: "シュメール人の受験生")
        sign_in @account
      end

      it "一覧ページにリダイレクトされること" do
        get new_recruitment_path
        expect(response).to redirect_to recruitments_path
      end
    end

    context "ログインアカウントがステータス：教授のとき" do
      before do
        @account = create(:professor_account)
        @account.create_professor(name: "ズワイガニ教授")
        sign_in @account
      end

      it "ステータス200を返すこと" do
        get new_recruitment_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #edit" do
    before do
      @recruitment = create(:recruitment)
    end

    context "未ログイン時" do
      it "ログインページにリダイレクトされること" do
        get edit_recruitment_path(@recruitment)
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがstatus::candidateのとき" do
      before do
        @account = create(:candidate_account)
        sign_in @account
      end

      it "一覧ページにリダイレクトされること" do
        get edit_recruitment_path(@recruitment)
        expect(response).to redirect_to recruitments_path
      end
    end

    context "ログインアカウントがstatus::professorで、募集の投稿者でないとき" do
      before do
        account = create(:professor_account)
        account.create_professor!(name: 'カニ教授')
        sign_in account
      end

      it "詳細ページにリダイレクトされること" do
        get edit_recruitment_path(@recruitment)
        expect(response).to redirect_to recruitment_path(@recruitment)
      end
    end

    context "ログインアカウントがstatus::professorで、募集の投稿者であるとき" do
      before do
        account = @recruitment.professor.account
        sign_in account
      end

      it "ステータス200を返すこと" do
        get edit_recruitment_path(@recruitment)
        expect(response).to have_http_status(200)
      end
    end
  end
end
