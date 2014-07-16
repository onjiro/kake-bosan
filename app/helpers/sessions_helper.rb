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
    initial_assets = YAML.load(ERB.new(<<-EOD).result)
      <%= Accounting::Type::ASSET.id %>:
        - { name: 現金         , description: 現金として所持している金額を表す科目 }
        - { name: 普通預金     , description: 普通預金口座を表す科目。金融機関、口座別の科目を作成するのがオススメ }
        - { name: 電子マネー   , description: 電子マネー等を表す科目。種類別の科目を作成するのがオススメ }
        - { name: ポイント     , description: 各店舗のポイントを表す科目。店舗別に作成するのがオススメ }
      <%= Accounting::Type::EXPENSE.id %>:
        - { name: 食費         , description: ひみつ }
        - { name: 日用品       , description: ひみつ }
        - { name: 雑貨         , description: ひみつ }
        - { name: 遊興費       , description: ひみつ }
        - { name: 住宅費       , description: ひみつ }
        - { name: 電気料金     , description: ひみつ }
        - { name: ガス料金     , description: ひみつ }
        - { name: 水道料金     , description: ひみつ }
        - { name: 通信費       , description: ひみつ }
        - { name: 交通費       , description: ひみつ }
        - { name: 医療費       , description: ひみつ }
        - { name: 被服費       , description: ひみつ }
        - { name: 教育費       , description: ひみつ }
        - { name: 交際費       , description: 祝儀・お見舞い・慶弔費（香典など）・会食代など }
        - { name: 生命保険・医療保険
                               , description: ひみつ }
        - { name: 自動車保険   , description: ひみつ }
        - { name: 健康保険     , description: ひみつ }
        - { name: 国民年金・厚生年金・共済年金
                               , description: ひみつ }
        - { name: 雇用保険     , description: ひみつ }
        - { name: 所得税       , description: ひみつ }
        - { name: 住民税       , description: ひみつ }
        - { name: 固定資産税   , description: ひみつ }
        - { name: 手数料       , description: ひみつ }
        - { name: その他費用   , description: ひみつ }
      <%= Accounting::Type::LIABILITY.id %>:
        - { name: カード決済   , description: ひみつ }
        - { name: 借金         , description: ひみつ }
      <%= Accounting::Type::CAPITAL.id %>: []
      <%= Accounting::Type::INCOME.id %>:
        - { name: 給与収入     , description: ひみつ }
        - { name: その他雑収入 , description: ひみつ }
    EOD
    initial_assets.each_pair do |accounting_type_id, items|
      items.each do |item|
        Accounting::Item.new(item.merge(user_id: user.id, accounting_type_id: accounting_type_id)).save()
      end
    end
  end
end
