state("Anger Foot")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Anger Foot";
    vars.Helper.AlertRealTime();

    settings.Add("MapLoad", false, "Exclude Map from Load-Removed Time");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Paused"] = mono.Make<bool>("GameState", "_isGamePaused");
        vars.Helper["ChangingScene"] = mono.Make<bool>("GameState", "_isChangingScene");
        vars.Helper["LoadingScene"] = mono.Make<bool>("GameState", "_isLoadingScene");
        vars.Helper["Level"] = mono.Make<int>("GameState", "_currentLevel");
        return true;
    });
}

isLoading
{
    if(settings["MapLoad"] && current.Level == 0) {
        return true;
    }
    return current.ChangingScene || current.LoadingScene;
}

start
{
    return current.Level != 0 && old.Level == 0;
}

split
{
    return current.Level == 0 && old.Level != 0;
}
