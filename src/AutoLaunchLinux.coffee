untildify           = require 'untildify'
fileBasedUtilities  = require './fileBasedUtilities'

module.exports =

    ### Public ###

    # options - {Object}
    #   :appName - {String}
    #   :appPath - {String}
    #   :isHiddenOnLaunch - {Boolean}
    # Returns a Promise
    enable: ({appName, appPath, isHiddenOnLaunch}) ->
        hiddenArg = if isHiddenOnLaunch then ' --hidden' else ''

        data = """[Desktop Entry]
                Type=Application
                Version=1.0
                Name=#{appName}
                Comment=#{appName} Startup Script
                Exec="#{appPath}" #{hiddenArg}
                StartupNotify=false
                Terminal=false"""

        return fileBasedUtilities.createFile {
            data
            directory: @getDirectory()
            filePath: @getFilePath appName
        }


    # appName - {String}
    # Returns a Promise
    disable: (appName) -> fileBasedUtilities.removeFile @getFilePath appName


    # appName - {String}
    # Returns a Promise which resolves to a {Boolean}
    isEnabled: (appName) -> fileBasedUtilities.isEnabled @getFilePath appName


    ### Private ###


    # Returns a {String}
    getDirectory: -> untildify '~/.config/autostart/'


    # appName - {String}
    # Returns a {String}
    getFilePath: (appName) -> "#{@getDirectory()}#{appName}.desktop"