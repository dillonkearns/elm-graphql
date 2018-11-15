module RepoWithOwner exposing (RepoWithOwner, elmPackageUrl, ownerAndRepo, repoWithOwner, toString)


type RepoWithOwner
    = RepoWithOwner String


repoWithOwner value =
    RepoWithOwner value


elmPackageUrl : RepoWithOwner -> String
elmPackageUrl repoWithOwnerValue =
    "http://package.elm-lang.org/packages/" ++ toString repoWithOwnerValue ++ "/latest"


toString (RepoWithOwner value) =
    value


ownerAndRepo : RepoWithOwner -> { owner : String, repoName : String }
ownerAndRepo (RepoWithOwner value) =
    case value |> String.split "/" of
        [ owner, repoName ] ->
            { owner = owner, repoName = repoName }

        _ ->
            { owner = "???", repoName = "???" }
