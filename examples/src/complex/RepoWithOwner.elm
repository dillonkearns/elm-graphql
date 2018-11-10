module RepoWithOwner exposing (RepoWithOwner, elmPackageUrl, repoWithOwner, toString)


type RepoWithOwner
    = RepoWithOwner String


repoWithOwner value =
    RepoWithOwner value


elmPackageUrl : RepoWithOwner -> String
elmPackageUrl repoWithOwnerValue =
    "http://package.elm-lang.org/packages/" ++ toString repoWithOwnerValue ++ "/latest"


toString (RepoWithOwner value) =
    value
