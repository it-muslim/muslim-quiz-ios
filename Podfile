platform :ios, '9.0'

def firebase
    pod 'Firebase/Core'
    pod 'Firebase/Storage'
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'Firebase/Messaging'
end


def networking
#    pod 'Alamofire'
    pod 'SwiftyJSON'
end

def reactive
#    pod 'RxSwift'
#    pod 'RxCocoa'
#    pod 'RxAlamofire'
end

def database
#    pod 'Realm'
end

def logging
    pod 'CocoaLumberjack/Swift'
    pod 'BugfenderSDK'
end

def ui
    pod 'IGListKit'
    pod 'SnapKit'
    pod 'SDWebImage'
    pod 'MBProgressHUD'
end

def di
    pod 'Swinject'
end

def social
    pod 'VK-ios-sdk'
    pod 'FBSDKCoreKit'
    pod 'FBSDKLoginKit'
end

target 'Muslim Quiz' do
    use_frameworks!
    
    networking
    reactive
    ui
    di
    database
    logging
    firebase
    social

    target 'Muslim QuizTests' do
        inherit! :search_paths
        # Pods for testing
    end

end
