xml.instruct! :xml, version: 1.0
xml.rss(version: '2.0') do
  xml.title "OVERVIEW"
  xml.link "http://kurorekishi.me/cleaner"
  xml.about "http://kurorekishi.me/service/kpi/overview"
  xml.lastBuildDate Time.zone.now.to_s(:rfc822)

  xml.item do
    xml.processing @item[:processing]
    xml.collecting @item[:collecting]
    xml.cleaning   @item[:cleaning]
    xml.tweets     @item[:tweets]
  end
end
