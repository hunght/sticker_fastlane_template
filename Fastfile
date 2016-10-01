# Customise this file, documentation can be found here: 
# https://github.com/krausefx/fastlane#customise-the-fastfile

# Change the syntax highlighting to Ruby

# All lines starting with a # are ignored when running `fastlane`

before_all do
  # ENV["SLACK_URL"] = "https://hooks.slack.com/services/..."
  # ENV['SIGH_TEAM_ID'] = 'Q2CBPJ58CC'
  # sh "./customShellScript.sh"

  # increment_build_number
  
  # cocoapods

  # xctool :test

  # snapshot
end

lane:name do
    produce(
        app_name: '{Appname}',
        language: 'English',
        app_version: '1.0',
    )
end

  lane :release do
    # match(type: "appstore")
    # snapshot
    # 4
    cert
    # 5
    sigh(force: true)
    gym(scheme: "StickerPackExtension") # Build your app - more options available
    deliver(force: true)
    # frameit
  end

  lane :prodution do
    # match(type: "appstore")
    # snapshot
    # 4
      produce(
        app_name: '{Appname}',
        language: 'English',
        app_version: '1.0',
    )
    cert
    # 5
    sigh(force: true)
    gym(scheme: "StickerPackExtension") # Build your app - more options available
    deliver(force: true)
    # frameit
  end

# You can define as many lanes as you want

after_all do |lane|
  # This block is called, only if the executed lane was successful
  # slack({
  #   message: "Successfully deployed new App Update for [App](http://link.com).",
  #   success: true,
  #   channel: 'development'
  # })
end


error do |lane, exception|
  # Something bad happened
end