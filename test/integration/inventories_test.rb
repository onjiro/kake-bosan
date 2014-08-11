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
end
