module SessionsHelper
  def find_or_create_user(auth_params)
    return User.find_by_provider_and_uid(auth_params["provider"], auth_params["uid"]) ||
      create_user_account(auth_params)
  end

  private
  def create_user_account(auth_params)
    user = User.create_with_omniauth(auth_params)
    create_initial_asset_datas(user)
    return user
  end

  def create_initial_asset_datas(user)
    # TODO 初期データを yml ファイルか何かに外出しにしておきたい
    {
      Accounting::Type::ASSET.id => [
                                     ['現金'      , '現金として所持している金額を表す科目'],
                                     ['普通預金'  , '普通預金口座を表す科目。金融機関、口座別の科目を作成するのがオススメ'],
                                     ['電子マネー', '電子マネー等を表す科目。種類別の科目を作成するのがオススメ'],
                                     ['ポイント'  , '各店舗のポイントを表す科目。店舗別に作成するのがオススメ'],
                                    ],
      Accounting::Type::EXPENSE.id => [
                                       ['食費'                        , ''],
                                       ['日用品'                      , ''],
                                       ['雑貨'                        , ''],
                                       ['遊興費'                      , ''],
                                       ['住宅費'                      , ''],
                                       ['電気料金'                    , ''],
                                       ['ガス料金'                    , ''],
                                       ['水道料金'                    , ''],
                                       ['通信費'                      , ''],
                                       ['交通費'                      , ''],
                                       ['医療費'                      , ''],
                                       ['被服費'                      , ''],
                                       ['教育費'                      , ''],
                                       ['交際費'                      , '祝儀・お見舞い・慶弔費（香典など）・会食代など'],
                                       ['生命保険・医療保険'          , ''],
                                       ['自動車保険'                  , ''],
                                       ['健康保険'                    , ''],
                                       ['国民年金・厚生年金・共済年金', ''],
                                       ['雇用保険'                    , ''],
                                       ['所得税'                      , ''],
                                       ['住民税'                      , ''],
                                       ['固定資産税'                  , ''],
                                       ['手数料'                      , ''],
                                       ['その他費用'                  , ''],
                                      ],
      Accounting::Type::LIABILITY.id => [
                                         ['カード決済', ''],
                                         ['借金'      , ''],
                                        ],
      Accounting::Type::CAPITAL.id => [
                                      ],
      Accounting::Type::INCOME.id => [
                                      ['給与収入'    , ''],
                                      ['その他雑収入', ''],
                                     ],
    }.each_pair do |asset_type_id, asset_items|
      asset_items.each do |name, description|
        Accounting::Item.new({
                               user_id: user.id,
                               name: name,
                               accounting_type_id: asset_type_id,
                               description: description,
                             }).save()
      end
    end
  end
end
