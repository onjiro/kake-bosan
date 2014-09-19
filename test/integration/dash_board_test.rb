require 'test_helper'

class DashBoardTest < ActionDispatch::IntegrationTest
  setup do
    sign_out
    sign_in
  end

  test '/dash_board が開けること' do
    visit '/dash_board'
    assert { page.has_content? '家計簿さん' }
  end
end
