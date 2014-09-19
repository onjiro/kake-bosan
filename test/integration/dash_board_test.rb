require 'test_helper'

class DashBoardTest < ActionDispatch::IntegrationTest
  setup do
    sign_out
    sign_in
  end

  test 'サイドメニューにダッシュボードへのリンクがあること' do
    click_link 'ダッシュボード'

    assert { page.current_path == '/dash_board' }
  end
end
