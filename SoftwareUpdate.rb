require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'json'
require 'net/http'
require 'net/https'

agent = Mechanize.new {|agent|
  agent.user_agent_alias = 'Mac Safari'
}

#This is the part of the code that updates the newest version by checking the website where we downloaded it from.
newestVersions = Hash.new

linksJAMF = [64, 73, 226, 345, 343, 374, 241, 101, 326, 342, 344, 113, 171, 366, 236, 72, 41,328, 112, 469,135, 498,
            327,503,518,125,509, 1, 5,561,203]
namesJAMF = ["Final Cut Pro", "Google Chrome", "iBooks Author", "iMovie", "Keynote", "Logic Pro X", "Mathematica",
          "Microsoft Remote Desktop", "Motion", "Numbers", "Pages", "Skype", "Xcode","Adobe Acrobat XI",
          "AnyConnect","Firefox", "Flash Player", "Maple", "Silverlight", "XQuartz","Mac OS X", "HandBrake", "Compressor",
          "Adobe Creative Cloud", "GarageBand", "VLC Media Player", "Blender", "Casper Suite", "Deep Freeze","R","dockutil"]

i=0
linksJAMF.each {|number|
    url = "https://www.jamf.com/jamf-nation/third-party-products/#{number}"
    page = agent.get(url)
    file=page.parser.xpath("//ul[@class='product-details']//li").to_s
    file=file[file.index('Current Version: </strong>')+26,file.length]
    version=file[0, file.index('<')]
    title= namesJAMF[i]
    i=i+1
    newestVersions[title]=version
}

#Any Video Converter Lite
url = "https://itunes.apple.com/us/app/any-video-converter-lite/id479472944?mt=12"
page = agent.get(url)
file= page.parser.xpath("//ul[@class='list']").to_s
file=file[file.index('softwareVersion')+17,30]
version=file[0,file.index('<')]
title="Any Video Converter Lite"
namesJAMF.push(title)
newestVersions[title]=version

#Audacity
url = "http://www.audacityteam.org/download/"
page = agent.get(url)
file=page.parser.to_s
file=file[file.index('<div class="downloads_header">')+44,20]
version=file[0,file.index('<')]
title="Audacity"
namesJAMF.push(title)
newestVersions[title]=version

#Cytoscape
url = "http://www.cytoscape.org/releasenotes.html"
page = agent.get(url)
file=page.parser.to_s
file=file[file.index('<h2>Latest Version</h2>')+67,20]
version=file[0,file.index('.')]
version.gsub!('_','.')
title="Cytoscape"
namesJAMF.push(title)
newestVersions[title]=version

#Inkscape
url = "https://inkscape.org/en/download/mac-os/"
page = agent.get(url)
file=page.parser.to_s
file=file[file.index('<h2>Inkscape') + 13 ,20]
version=file[0,file.index('<')]
title="Inkscape"
namesJAMF.push(title)
newestVersions[title]=version

#Lame Library
url = "http://lame.buanzo.org/#lameosxdl"
page = agent.get(url)
file=page.parser.to_s
file=file[file.index('Lame_Library_')+14,20]
version=file[0,file.index('_')]
title="Lame Library for Audacity"
namesJAMF.push(title)
newestVersions[title]=version

#Makerbot
url = "https://www.makerbot.com/download-desktop/"
page = agent.get(url)
file=page.parser.to_s
file=file[file.index('<h2>Version')+28,20]
version=file[0,file.index(' ')]
title="MakerBot Bundle BETA"
namesJAMF.push(title)
newestVersions[title]=version

#RStudio
url = "https://www.rstudio.com/products/rstudio/download/"
page = agent.get(url)
file=page.parser.to_s
file=file[file.index('<strong>RStudio Desktop')+24,20]
version=file[0,file.index('<')]
title="RStudio"
namesJAMF.push(title)
newestVersions[title]=version

needUpdated=Array.new
namesJAMF.each {|package|
  name=package
  version=newestVersions[package]

}
url = "https://[user]:[password]@[url]"
page = agent.get(url)
file = page.parser.to_s
puts page

File.open('app/views/welcome/jssAppsInstalled.sh','w') do |write|

    a.puts "#!/bin/bash
    namesJAMF.each{|app|
      write.puts('curl -s -u [user]:[password] [url]application/#{app}/version/#{version}')
    }
      File.(jssAppsInstalled.sh).length
end

File.open('app/views/welcome/homepage.html.erb','w') do |a|

    a.puts "<!DOCTYPE html>
    <html lang=\"en\">
    <head>
        <meta charset=\"utf-8\">
        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
        <meta name=\"description\" content=\"\">
        <meta name=\"author\" content=\"\">
        <title>Bare - Start Bootstrap Template</title>
        <link href=\"css/bootstrap.min.css\" rel=\"stylesheet\">
        <style>
        body {
            padding-top: 70px;
        }
        </style>
    </head>
    <body>
        <div class=\"container\">
            <div class=\"row\">
                <div class=\"col-lg-12 text-center\">"
      i=needUpdated.length

      a.puts "<h3><strong>There are <span class= \"label label-danger\">#{i}</span> applications that need updated</strong></h3><br>"
      a.puts "<h4><ul class=\"list-unstyled\">"

    needUpdated.each{|name|
      a.puts "<li>"
      a.puts name
      a.puts "</li><br>"
    }

    a.puts "</h4></li>"
    a.puts "</ul>"
    a.puts "</div></div></div>"
    a.puts "<script src=\"js/jquery.js\"></script>"
    a.puts "<script src=\"js/bootstrap.min.js\"></script>"
    a.puts "</body></html>"
end
