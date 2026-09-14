$Hex = '63336c756448743661486c6e646c396d5a323530636c396d61484277636d5a6d66513d3d'

$Bytes = for ($Index = 0; $Index -lt $Hex.Length; $Index += 2) {
    [Convert]::ToByte($Hex.Substring($Index, 2), 16)
}

$Base64 = [Text.Encoding]::ASCII.GetString($Bytes)
$Rot13 = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($Base64))
$Input = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
$Output = 'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'

for ($Position = 0; $Position -lt $Rot13.Length; $Position++) {
    $Character = $Rot13[$Position]
    $Index = $Input.IndexOf($Character)
    if ($Index -ge 0) { $Output[$Index] } else { $Character }
}
