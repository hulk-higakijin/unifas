require 'rails_helper'

RSpec.describe "Recruitments", type: :request do
  let(:valid_params) {{ title: 'create newfuture', body: 'hello, my world.', faculty_id: Faculty.last.id}}
  let(:invalid_params) {{ title: nil, body: nil, faculty_id: Faculty.last.id + 1}}

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

  describe "POST #create" do
    before do
      @faculty = create(:faculty)
    end

    context "未ログイン時" do
      it 'ログインページにリダイレクトされること' do
        post recruitments_path, params: { recruitment: valid_params }
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがstatus::candidateのとき" do
      before do
        candidate = create(:candidate)
        sign_in candidate.account
      end

      it '一覧ページにリダイレクトされること' do
        post recruitments_path, params: { recruitment: valid_params }
        expect(response).to redirect_to recruitments_path
      end
    end

    context "ログインアカウントがstatus::professorのとき" do
      before do
        professor = create(:professor)
        sign_in professor.account
      end

      describe '成功時' do
        it 'モデルが1つ追加されること' do
          expect do
            post recruitments_path, params: { recruitment: valid_params }
          end.to change { Recruitment.count }.by(1)
        end

        it '詳細ページにリダイレクトされること' do
          post recruitments_path, params: { recruitment: valid_params }
          expect(response).to redirect_to recruitment_path(Recruitment.last)
        end
      end

      describe '失敗時' do
        it 'モデル数が変化しないこと' do
          expect do
            post recruitments_path, params: { recruitment: invalid_params }
          end.to change { Recruitment.count }.by(0)
        end

        it 'newページがレンダリングされること' do
          post recruitments_path, params: { recruitment: invalid_params }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe "PUT #update" do
    before do
      @recruitment = create(:recruitment)
    end

    context "未ログイン時" do
      it 'ログインページにリダイレクトされること' do
        put recruitment_path(@recruitment), params: { recruitment: valid_params }
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがstatus::candidateのとき" do
      before do
        candidate = create(:candidate)
        sign_in candidate.account
      end

      it "一覧ページにリダイレクトされること" do
        put recruitment_path(@recruitment), params: { recruitment: valid_params }
        expect(response).to redirect_to recruitments_path
      end
    end

    context "ログインアカウントがstatus::professorで、募集の投稿者でないとき" do
      before do
        professor = create(:professor)
        sign_in professor.account
      end

      it "詳細ページにリダイレクトされること" do
        put recruitment_path(@recruitment), params: { recruitment: valid_params }
        expect(response).to redirect_to recruitment_path(@recruitment)
      end
    end

    context "ログインアカウントがstatus::professorで、募集の投稿者のとき" do
      before do
        sign_in @recruitment.professor.account
      end

      describe "成功時" do
        it "更新した募集の値が変わること" do
          expect do
            put recruitment_path(@recruitment), params: { recruitment: valid_params }
          end.to change { Recruitment.find(@recruitment.id).title }.from("create superfuture!!!").to('create newfuture')
        end

        it "モデル数が変化しないこと" do
          expect do
            put recruitment_path(@recruitment), params: { recruitment: valid_params }
          end.to change { Recruitment.count }.by(0)
        end

        it "詳細ページにリダイレクトされること" do
          put recruitment_path(@recruitment), params: { recruitment: valid_params }
          expect(response).to redirect_to recruitment_path(@recruitment)
        end
      end

      describe "失敗時" do
        it "募集の値は変わらないこと" do
          expect do
            put recruitment_path(@recruitment), params: { recruitment: invalid_params }
          end.not_to change { Recruitment.find(@recruitment.id).title }
        end

        it "editページがレンダリングされること" do
          put recruitment_path(@recruitment), params: { recruitment: invalid_params }
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
