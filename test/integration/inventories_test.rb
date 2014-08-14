require 'test_helper'

class InventoriesTest < ActionDispatch::IntegrationTest
  setup do
    sign_out
    sign_in
  end

  test 'サイドメニューに /inventories へのリンクがあること' do
    click_link '棚卸し'

    assert { page.current_path == '/inventories' }
    save_screenshot "#{Rails.root}/screenshots/inventories_index.png"
  end

  test '現在の資産の額を確認できること' do
    assert { page.have_no_content? 'ロード中...' }
    skip
  end

  test '現在の実資産額を登録できること' do
    skip
  end
end
