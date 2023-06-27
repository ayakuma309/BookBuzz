module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
                  '管理画面'
                else
                  'マスクをした本たち'
                end
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'マスクをした本たち',
      title: 'マスクをした本たち',
      reverse: true,
      charset: 'utf-8',
      description: 'いつもとは違った方法で本を選ぶサービス',
      keywords: 'マスクをした本たち, 本の宝さがし, おすすめの本',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@ZCunkuma',
        image: image_url('ogp.png'),
      }
    }
  end
end
