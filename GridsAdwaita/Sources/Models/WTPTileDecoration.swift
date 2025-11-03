enum WTPTileDecoration {
    case normal
    case fixed
    case invisible

    var localizedName: String {
        switch self {
        case .normal: "Normal"
        case .fixed: "Fixed"
        case .invisible: "Invisible"
        }
    }
}