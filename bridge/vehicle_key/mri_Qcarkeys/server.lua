local vehicle_key = {}
local mri_Qcarkeys = exports.mri_Qcarkeys

function vehicle_key.GiveTempKeys(source, plate)
    mri_Qcarkeys:GiveTempKeys(source, plate)
end

function vehicle_key.RemoveTempKeys(source, plate)
    mri_Qcarkeys:RemoveTempKeys(source, plate)
end

function vehicle_key.GiveKeyItem(source, plate, netId)
    mri_Qcarkeys:GiveKeyItem(source, plate, netId)
end

function vehicle_key.RemoveKeyItem(source, plate)
    mri_Qcarkeys:RemoveKeyItem(source, plate)
end

function vehicle_key.HaveTemporaryKey(source, plate)
    return mri_Qcarkeys:HaveTemporaryKey(source, plate)
end

function vehicle_key.HavePermanentKey(source, plate)
    return mri_Qcarkeys:HavePermanentKey(source, plate)
end

return vehicle_key
