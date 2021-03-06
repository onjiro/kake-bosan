require 'test_helper'

class InventoriesTest < ActionDispatch::IntegrationTest
  setup do
    sign_out
    sign_in
  end

  test 'サイドメニューに /inventories へのリンクがあること' do
    click_link '棚卸し'

    assert { page.current_path == '/inventories' }
  end

  test '現在の資産の額を確認できること' do
    fill_in 'debit-amount', with: 1
    select '食費', from: 'debit-account'
    select '現金', from: 'credit-account'
    click_button '登録'
    assert { all('.history tbody').size == 1 }

    click_link '棚卸し'
    assert { page.has_no_content? 'ロード中・・・' }

    assert { all('.inventories tbody').size == 20 }
    row = all('.inventories tbody tr').first
    assert { row.has_content? '現金' }
    assert { row.has_content? '資産' }
    assert { row.has_content? '-1' }

    save_screenshot "#{Rails.root}/screenshots/inventories_index.png"
  end

  test '無効化された科目は表示されないこと' do
    click_link '設定'
    assert { page.has_no_content? 'ロード中・・・' }
    row = all('.account-items-configs tbody tr').first.click_button '無効化'

    click_link '棚卸し'
    assert { page.has_no_content? 'ロード中・・・' }

    assert { all('.inventories tbody').size == 19 }
    assert { page.has_no_content? '現金' }
  end

  # test '現在の実資産額を登録できること' do
  #   skip
  # end
end
