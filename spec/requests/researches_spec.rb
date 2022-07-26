require 'rails_helper'

RSpec.describe "Researches", type: :request do
  let(:valid_params) {{ title: 'create newfuture', body: 'hello, my world.', faculty_id: Faculty.last.id}}
  let(:invalid_params) {{ title: nil, body: nil, faculty_id: Faculty.last.id + 1}}

  describe "GET #index" do
    it "ステータス200を返すこと" do
      get researches_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before do
      @research = create(:research)
    end

    context "正常時" do
      it "ステータス200を返すこと" do
        get research_path(@research)
        expect(response).to have_http_status(200)
      end
    end

    context "研究が存在しないとき" do
      it "NotFoundエラーを起こすこと" do
        expect do
          get research_path(@research.id + 1)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #new" do
    context "未ログイン時" do
      it "ログインページにリダイレクトされること" do
        get new_research_path
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがstauts::candidateのとき" do
      before do
        candidate = create(:candidate)
        sign_in candidate.account
      end

      it "一覧ページにリダイレクトされること" do
        get new_research_path
        expect(response).to redirect_to researches_path
      end
    end

    context "ログインアカウントがstatus::professorのとき" do
      before do
        professor = create(:professor)
        sign_in professor.account
      end

      it "ステータス200を返すこと" do
        get new_research_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #edit" do
    before do
      @research = create(:research)
    end

    context "未ログイン時" do
      it "ログインページにリダイレクトされること" do
        get edit_research_path(@research)
        expect(response).to redirect_to new_account_session_path
      end
    end

    context "ログインアカウントがstatus::candidateのとき" do
      before do
        candidate = create(:candidate)
        sign_in candidate.account
      end

      it "詳細ページにリダイレクトされること" do
        get edit_research_path(@research)
        expect(response).to redirect_to researches_path
      end
    end

    context "ログインアカウントがstatus::professorのときで、研究の投稿者でないとき" do
      before do
        account = create(:professor_account)
        account.create_professor!(name: 'かに教授')
        sign_in account
      end

      it "詳細ページにリダイレクトされること" do
        expect do
          get edit_research_path(@research)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "ログインアカウントがstatus::professorのときで、研究の投稿者のとき" do
      before do
        sign_in @research.professor.account
      end

      describe "正常時" do
        it "ステータス200を返すこと" do
          get edit_research_path(@research)
          expect(response).to have_http_status(200)
        end
      end

      describe "存在しない研究にアクセスされると" do
        it "NotFoundエラーを返すこと" do
          expect do
            get edit_research_path(@research.id + 1)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "POST #create" do
    before do
      create(:faculty)
    end

    context "未ログイン時" do
      it "ログインページにリダイレクトされること" do
        post researches_path, params: { research: valid_params }
        expect(response).to redirect_to account_session_path
      end
    end

    context "ログインアカウントがstatus::candidateのとき" do
      before do
        candidate = create(:candidate)
        sign_in candidate.account
      end
      it "一覧ページにリダイレクトされること" do
        post researches_path, params: { research: valid_params }
        expect(response).to redirect_to researches_path
      end
    end

    context "ログインアカウントがstauts::professorのとき" do
      before do
        professor = create(:professor)
        sign_in professor.account
      end

      describe "成功時" do
        it "モデル数が1増えること" do
          expect do
            post researches_path, params: { research: valid_params }
          end.to change { Research.count }.by(1)
        end

        it "詳細ページにリダイレクトされること" do
          post researches_path, params: { research: valid_params }
          expect(response).to redirect_to research_path(Research.last)
        end
      end

      describe "失敗時" do
        it "newページがレンダリングされること" do
          post researches_path, params: { research: invalid_params }
          expect(response).to render_template(:new)
        end

        it "モデル数に変化がないこと" do
          expect do
            post researches_path, params: { research: invalid_params }
          end.to change { Research.count }.by(0)
        end
      end
    end
  end

  describe "PUT #update" do
    before do
      @research = create(:research)
    end

    context "未ログイン時" do
      it "ログインページにリダイレクトされること" do
        put research_path(@research), params: { research: valid_params }
        expect(response).to redirect_to account_session_path
      end
    end


    context "ログインアカウントがstatus::accountのとき" do
      before do
        candidate = create(:candidate)
        sign_in candidate.account
      end

      it "一覧ページにリダイレクトされること" do
        put research_path(@research), params: { research: valid_params }
        expect(response).to redirect_to researches_path
      end
    end

    context "ログインアカウントがstauts::professorで、募集の投稿者でないとき" do
      before do
        professor = create(:professor)
        sign_in professor.account
      end

      it "NotFoundエラーが起きること" do
        expect do
          put research_path(@research), params: { research: valid_params }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "ログインアカウントがstauts::professorで、募集の投稿者のとき" do
      before do
        sign_in @research.professor.account
      end

      describe "成功時" do
        it "値が変わること" do
          expect do
            put research_path(@research), params: { research: valid_params }
          end.to change { Research.find(@research.id).title }.from("we did found truth world").to('create newfuture')
        end

        it "モデル数は変化しないこと" do
          expect do
            put research_path(@research), params: { research: valid_params }
          end.to change { Research.count }.by(0)
        end

        it "詳細ページにリダイレクトされること" do
          put research_path(@research), params: { research: valid_params }
          expect(response).to redirect_to research_path(Research.find(@research.id))
        end
      end

      describe "失敗時" do
        it "値は変化しないこと" do
          expect do
            put research_path(@research), params: { research: invalid_params }
          end.not_to change { Research.find(@research.id).title }
        end

        it "editページがレンダリングされること" do
          put research_path(@research), params: { research: invalid_params }
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
