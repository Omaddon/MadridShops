platform :ios, '10.0'
use_frameworks!

# Como una función, para poner los pods comunes a varios targets
def common_pods
    # instala la última
    # pod 'DotsLoading'
    pod 'FillableLoaders', '~> 1.3.0'
    
    # instala una versión en concreto
    # pod 'DotsLoading', '~> 1.1.0'
end

target 'MadridShops' do
    common_pods
end

target 'MadridShopsTests' do
    common_pods
end

# $>pod repo update
# $>pod install
# $>pod deintegrate     'para eliminar CocoaPods del proyecto'
# $>pod update          'para actualizar los Pods instalados'
