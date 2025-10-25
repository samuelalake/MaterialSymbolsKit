/// Material Symbols as SF Symbols for iOS
///
/// This package provides Material Design symbols in SF Symbol format,
/// enabling type-safe usage with SwiftUI and UIKit.
///
/// ## Weight Support
/// Material Symbols include 7 native weights (100-700):
/// - Ultralight, Thin, Light, Regular, Medium, Semibold, Bold
///
/// Heavy (800) and Black (900) weights are interpolated by iOS from Bold (700).
///
/// ## Usage
/// ```swift
/// import SwiftUI
/// import MaterialSymbolsKit
///
/// Image(materialSymbol: .home)
///     .font(.largeTitle)
/// ```
public enum MaterialSymbols: String, CaseIterable, Sendable {
    case add = "material.add"
    case alarm = "material.alarm"
    case arrowBack = "material.arrow_back"
    case arrowForward = "material.arrow_forward"
    case attachFile = "material.attach_file"
    case attachment = "material.attachment"
    case bookmark = "material.bookmark"
    case calendarToday = "material.calendar_today"
    case camera = "material.camera"
    case cancel = "material.cancel"
    case chat = "material.chat"
    case check = "material.check"
    case checkCircle = "material.check_circle"
    case chevronLeft = "material.chevron_left"
    case chevronRight = "material.chevron_right"
    case close = "material.close"
    case cloud = "material.cloud"
    case cloudDownload = "material.cloud_download"
    case cloudUpload = "material.cloud_upload"
    case computer = "material.computer"
    case contactMail = "material.contact_mail"
    case contactPhone = "material.contact_phone"
    case contentCopy = "material.content_copy"
    case contentCut = "material.content_cut"
    case contentPaste = "material.content_paste"
    case creditCard = "material.credit_card"
    case delete = "material.delete"
    case description = "material.description"
    case directions = "material.directions"
    case done = "material.done"
    case download = "material.download"
    case edit = "material.edit"
    case error = "material.error"
    case event = "material.event"
    case expandLess = "material.expand_less"
    case expandMore = "material.expand_more"
    case favorite = "material.favorite"
    case flag = "material.flag"
    case folder = "material.folder"
    case folderOpen = "material.folder_open"
    case group = "material.group"
    case help = "material.help"
    case home = "material.home"
    case info = "material.info"
    case keyboard = "material.keyboard"
    case link = "material.link"
    case locationOn = "material.location_on"
    case lock = "material.lock"
    case lockOpen = "material.lock_open"
    case map = "material.map"
    case menu = "material.menu"
    case mic = "material.mic"
    case moreHoriz = "material.more_horiz"
    case moreVert = "material.more_vert"
    case mouse = "material.mouse"
    case notifications = "material.notifications"
    case pause = "material.pause"
    case person = "material.person"
    case phoneIphone = "material.phone_iphone"
    case playArrow = "material.play_arrow"
    case print = "material.print"
    case redo = "material.redo"
    case refresh = "material.refresh"
    case remove = "material.remove"
    case report = "material.report"
    case save = "material.save"
    case scanner = "material.scanner"
    case schedule = "material.schedule"
    case search = "material.search"
    case send = "material.send"
    case settings = "material.settings"
    case share = "material.share"
    case shoppingCart = "material.shopping_cart"
    case star = "material.star"
    case stop = "material.stop"
    case tablet = "material.tablet"
    case thumbDown = "material.thumb_down"
    case thumbUp = "material.thumb_up"
    case undo = "material.undo"
    case upload = "material.upload"
    case visibility = "material.visibility"
    case visibilityOff = "material.visibility_off"
    case volumeDown = "material.volume_down"
    case volumeOff = "material.volume_off"
    case volumeUp = "material.volume_up"
    case warning = "material.warning"
    case watch = "material.watch"
}
