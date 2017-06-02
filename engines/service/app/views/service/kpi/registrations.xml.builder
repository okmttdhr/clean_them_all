xml.instruct! :xml, version: 1.0
xml.rss(version: '2.0') do
  xml.title "REGISTRATIONS"
  xml.link "http://kurorekishi.me/cleaner"
  xml.about "http://kurorekishi.me/service/kpi/registrations"
  xml.lastBuildDate Time.zone.now.to_s(:rfc822)

  xml.item do
    xml.users @item[:users]
    xml.jobs  @item[:jobs]
  end
end
