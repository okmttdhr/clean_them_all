xml.instruct! :xml, version: 1.0
xml.rss(version: '2.0') do
  xml.channel do
    xml.title "黒歴史クリーナー"
    xml.link "http://kurorekishi.me/cleaner"
    xml.description "KPI | 黒歴史クリーナー"
    xml.lastBuildDate Time.zone.now.to_s(:rfc822)

    xml.item do
      xml.title       'OVERVIEW'
      xml.description @overview.to_json
      xml.guid        "kpi_overview_#{Time.zone.now.to_s(:number)}", isPermaLink: false
      xml.pubDate     Time.zone.now.to_s(:rfc822)
    end

    xml.item do
      xml.title       'REGISTRATION'
      xml.description @registrations.to_json
      xml.guid        "kpi_registration_#{Time.zone.now.to_s(:number)}", isPermaLink: false
      xml.pubDate     Time.zone.now.to_s(:rfc822)
    end
  end
end
