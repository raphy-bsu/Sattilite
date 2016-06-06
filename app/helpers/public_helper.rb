module PublicHelper
  def fancyimage(name, width = 220)
    content_tag :a, href: image_url(name), class: 'fancy' do
      content_tag :img, nil, { src: image_url(name), width: width }
    end
  end
end
