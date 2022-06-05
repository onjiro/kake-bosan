class TransactionTest < ActionDispatch::IntegrationTest
  setup { sign_in }
  teardown { sign_out }

  test "取引が取得できること" do
    get "/accounting/transactions.json"
    assert_response :success
  end

  test "取引が登録できること" do
    post "/accounting/transactions.json", params: {
                                            transaction: {
                                              date: "2022-05-10",
                                              entries_attributes: [
                                                {
                                                  side_id: Accounting::Side::DEBIT.id,
                                                  item_id: @current_user.items.first.id,
                                                  amount: 100,
                                                },
                                                {
                                                  side_id: Accounting::Side::CREDIT.id,
                                                  item_id: @current_user.items.last.id,
                                                  amount: 100,
                                                },
                                              ],
                                            },
                                          }

    assert_response :success

    subject = @current_user.transactions.last
    assert subject.present?
    assert_equal "2022-05-10", subject.date.strftime("%Y-%m-%d")
    assert_equal 1, subject.entries.debits.size
    assert_equal @current_user.items.first.id, subject.entries.debits.first.item.id
    assert_equal 1, subject.entries.credits.size
    assert_equal @current_user.items.last.id, subject.entries.credits.first.item.id
  end
end
