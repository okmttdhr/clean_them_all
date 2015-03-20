require 'rails_helper'

feature 'CleanersController', type: :feature do
  background do
    @user = double(:user, id: 14186100, nickname: 'cohakim')
  end

  scenario 'トップページを表示する' do
    visit root_path

    expect(current_path).to eq getstarted_cleaner_path
    expect(page).to have_link 'ツイッターでログイン'
  end

  scenario 'RootURLにアクセスがあった' do
    visit cleaner_path

    expect(current_path).to eq getstarted_cleaner_path
    expect(page).to have_link 'ツイッターでログイン'
  end

  scenario 'お知らせページを表示する' do
    sign_in @user

    expect(current_path).to eq info_cleaner_path
    expect(page).to have_link '削除設定ページへ'
  end

  scenario '削除ジョブ登録ページを表示する' do
    sign_in @user
    click_on '削除設定ページへ'

    expect(current_path).to eq new_cleaner_path
    expect(page).to have_content 'cohakim'
    expect(page).to have_link '削除を開始する'
  end

  feature '削除ジョブ登録' do
    let(:active_job)     { Job.last }
    let(:created_params) { active_job.parameter }

    background do
      sign_in @user
      visit new_cleaner_path
    end

    scenario 'デフォルトのパラメータで削除ジョブを登録する' do
      find('#new_cleaner').submit_form! # 削除を開始する

      expect(current_path).to eq status_cleaner_path
      expect(active_job).to be_processing
      expect(active_job.user_id).to eq @user.id
      expect(created_params.signedin_at).to be_within(10).of(DateTime.now)
      expect(created_params.statuses_count).to eq 7777
      expect(created_params.collect_method).to eq 'timeline'
      expect(created_params.archive_url).to be_nil
      expect(created_params.protect_reply).to be false
      expect(created_params.protect_favorite).to be false
      expect(created_params.collect_from).to be_nil
      expect(created_params.collect_to).to be_nil
      expect(created_params.start_message).to be_kind_of String
      expect(created_params.finish_message).to be_kind_of String
    end

    scenario '収集方法を「全ツイート履歴」にして削除ジョブを登録する'

    scenario 'リプライ保護機能を有効にして削除ジョブを登録する' do
      check 'protect_reply'
      find('#new_cleaner').submit_form! # 削除を開始する

      expect(created_params.protect_reply).to be true
    end

    scenario 'お気に入り保護機能を有効にして削除ジョブを登録する' do
      check 'protect_favorite'
      find('#new_cleaner').submit_form! # 削除を開始する

      expect(created_params.protect_favorite).to be true
    end

    scenario '集計期間を指定して削除ジョブを登録する'
  end

  feature '削除ジョブ進捗ページ' do
    let!(:active_job) { create(:job, state, user_id: @user.id) }

    background do
      sign_in @user
      visit status_cleaner_path
    end

    context 'when active job is processing' do
      let(:state) { :processing }

      scenario '削除ジョブ進捗ページを表示する' do
        expect(current_path).to eq status_cleaner_path
        expect(page).to have_link 'Abort'
        expect(page).to have_link 'Result'
        expect(page).not_to have_css 'a#btn-abort[disabled]'
        expect(page).to have_css 'a#btn-confirm[disabled]'
      end

      scenario '削除ジョブ進捗確認ダイアログを表示する'

      scenario '削除処理を中断' do
        expect {
          click_on 'Abort'
        }.to change{
          active_job.reload.aasm.current_state
        }.from(:processing).to(:confirming)
        expect(current_path).to eq status_cleaner_path
      end
    end

    context 'when active job is confirming' do
      let(:state) { :confirming }

      scenario '削除ジョブ進捗ページを表示する' do
        expect(current_path).to eq status_cleaner_path
        expect(page).to have_link 'Abort'
        expect(page).to have_link 'Result'
        expect(page).to have_css 'a#btn-abort[disabled]'
        expect(page).not_to have_css 'a#btn-confirm[disabled]'
      end

      scenario '削除処理の完了を確認' do
        expect {
          click_on 'Result'
        }.to change{
          active_job.reload.aasm.current_state
        }.from(:confirming).to(:closing)
        expect(current_path).to eq result_cleaner_path
      end
    end
  end

  feature '結果ページ' do
    let!(:active_job) { create(:job, :closing, user_id: @user.id) }

    background do
      sign_in @user
      visit result_cleaner_path
    end

    scenario '結果ページを表示する' do
      expect(current_path).to eq result_cleaner_path
      expect(page).to have_content active_job.created_at.to_s(:db)
      expect(page).to have_content '正常に完了'
      expect(page).to have_link 'DONE'
    end

    scenario '削除ジョブ完了' do
      expect {
        click_on 'DONE'
      }.to change {
        active_job.reload.aasm.current_state
      }.from(:closing).to(:closed)
      expect(current_path).to eq getstarted_cleaner_path
    end
  end
end
