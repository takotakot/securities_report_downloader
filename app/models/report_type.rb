class ReportType < ApplicationRecord
  HASH_DATA = [
    {id: 1, name: '取引報告書'},
    {id: 2, name: '取引残高報告書'},
    {id: 3, name: '年間取引報告書'},
    {id: 4, name: '運用報告書'},
    {id: 5, name: 'その他'},
  ]
end
