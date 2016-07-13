require 'seeder'
require 'nokogiri'
require 'open-uri'

Rake::Task["db:seed"].clear

namespace :misc do
  task populate: :environment do
    5.times do
      d = Day.order('Random()').last
      dd = Day.new
      dd.user = d.user
      dd.country = d.country
      dd.save!
      d.moments.each do |m|
        mm = dd.moments.build
        mm.remote_photo_url = m.photo.url
        mm.time = m.time
        mm.legend = m.legend
        mm.save!
      end
    end
  end

  task :scrap, [:country, :url] => :environment do |t, args|

    country = args.country
    url = args.url
    TPrint.log "country #{country}"
    TPrint.log "scraping #{url}"

    doc =  Nokogiri::HTML open(url)
    id = url.split('/').last
    jsonUrl = "https://imgur.com/ajaxalbums/getimages/#{id}/hit.json?all=true"
    username = doc.css('a.post-account').first.content.strip
    TPrint.log "username: #{username}"
    # moments = []
    # doc.css('.post-image-container').each do |container|
    #   img_url = container.css(".post-image-placeholder").first.attr('src')
    #   title = container.css("h2").first
    #   title = title && title.content
    #   legend = container.css(".post-image-description").first
    #   legend = legend && legend.content
    #   moments << {
    #     img_url: img_url,
    #     title: title,
    #     legend: legend,
    #   }
    # end
    moments = JSON.parse open(jsonUrl).read

    email = "#{username}@onedayina.life".downcase
    u = User.where(email: email).last
    unless u.present?
      TPrint.log "creating User: #{email}"
      u = User.new
      u.first_name = username
      u.email = email
      u.password = u.password_confirmation = "onedayinalife"
      u.save!
    end
    d = Day.new
    d.country = country
    d.user = u
    d.save!
    moments["data"]["images"].each_with_index do |data, i|
      TPrint.log "moment", data
      next if data["animated"] == true
      m = d.moments.build
      m.seq = i
      m.title = CGI.unescapeHTML(data["title"]) if data["title"].present?
      url = "http://i.imgur.com/#{data["hash"]}#{data["ext"]}"
      m.remote_photo_url = url
      m.legend = CGI.unescapeHTML(data["description"]) if data["description"].present?
      tries = 5

      while !m.save && tries > 0 do
        tries = tries - 1
      end
    end
  end
end
