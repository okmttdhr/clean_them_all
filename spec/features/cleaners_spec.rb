require 'rails_helper'

feature 'Cleaners', type: :feature do
  background do
    @user = double(:user, id: 14186100, nickname: 'cohakim')
  end

  scenario 'お知らせページを表示する' do
    sign_in @user

    expect(current_path).to eq info_cleaner_path
  end

  scenario 'お知らせページから削除設定ページへ遷移する' do
    sign_in @user
    click_on '削除設定ページへ'

    expect(current_path).to eq new_cleaner_path
    expect(page).to have_content 'cohakim'
  end

  feature '削除設定をして削除を開始する' do
    subject(:job)    { Job.last }
    subject(:params) { job.parameter }

    background do
      sign_in @user
      visit new_cleaner_path
    end

    scenario 'デフォルトのパラメータで削除を開始する' do
      click_on '削除を開始する'

      expect(current_path).to eq cleaner_path

      expect(job).to be_processing
      expect(job).to be_collecting
      expect(job.user_id).to eq @user.id

      expect(params.signedin_at).to be_within(10).of(DateTime.current)
      expect(params.statuses_count).to eq 7777
      expect(params.collect_method).to eq 'timeline'
      expect(params.archive_url).to be_blank
      expect(params.protect_reply).to be false
      expect(params.protect_favorite).to be false
      expect(params.collect_from).to be_nil
      expect(params.collect_to).to be_nil
      expect(params.start_message).to be_kind_of String
      expect(params.finish_message).to be_kind_of String
    end

    scenario '収集方法を「全ツイート履歴」にして削除を開始する'

    scenario 'リプライ保護機能を有効にして削除ジョブを登録する' do
      check 'job_parameter_protect_reply'
      click_on '削除を開始する'

      expect(params.protect_reply).to be true
    end

    scenario 'お気に入り保護機能を有効にして削除を開始する' do
      check 'job_parameter_protect_favorite'
      click_on '削除を開始する'

      expect(params.protect_favorite).to be true
    end

    scenario '集計期間を指定して削除を開始する'
  end

  feature '削除ステータスページ' do
    let!(:user)       { create(:user, id: @user.id) }
    let!(:active_job) { create(:job, state, user_id: @user.id) }

    background do
      sign_in @user
      visit cleaner_path
    end

    context 'when active job is processing' do
      let(:state) { :processing }

      scenario '削除ステータスページを表示する' do
        expect(current_path).to eq cleaner_path
        expect(page).to have_link 'キャンセル'
        expect(page).to have_link '結果を見る'
      end

      scenario '削除ジョブ進捗確認ダイアログを表示する'

      scenario '削除処理を中断する' do
        expect {
          click_on 'キャンセル'
        }.to change{
          active_job.reload.aasm(:transition).current_state
        }.from(:processing).to(:confirming)
        expect(current_path).to eq cleaner_path
      end
    end

    context 'when active job is confirming' do
      let(:state) { :confirming }

      scenario '結果ページへ遷移する' do
        expect {
          click_on '結果を見る'
        }.to change{
          active_job.reload.aasm(:transition).current_state
        }.from(:confirming).to(:closing)
        expect(current_path).to eq cleaner_path
      end
    end
  end

  feature '結果ページ' do
    let!(:user)       { create(:user, id: @user.id) }
    let!(:active_job) { create(:job, :closing, user_id: @user.id) }

    background do
      sign_in @user
      visit cleaner_path
    end

    scenario '結果ページを表示する' do
      expect(current_path).to eq cleaner_path
      expect(page).to have_content '正常に完了'
      expect(page).to have_link 'DONE'
    end

    scenario '削除を完了する' do
      expect {
        click_on 'DONE'
      }.to change{
        active_job.reload.aasm(:transition).current_state
      }.from(:closing).to(:closed)
      expect(current_path).to eq getstarted_path
    end
  end
end
