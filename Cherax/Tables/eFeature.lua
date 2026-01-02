--#region eFeature

eFeature = {
    Heist = {
        Generic = {
            Cutscene = {
                hash = J("SN_Generic_Cutscene"),
                name = "Skip Cutscene",
                type = eFeatureType.Button,
                desc = "Tries to skip the current cutscene.",
                func = function()
                    eNative.CUTSCENE.STOP_CUTSCENE_IMMEDIATELY()
                    SilentLogger.LogInfo("[Skip Cutscene] 过场动画已被跳过 ツ")
                end
            },

            Skip = {
                hash = J("SN_Generic_Skip"),
                name = "Skip Checkpoint",
                type = eFeatureType.Button,
                desc = "Tries to skip the heist to the next checkpoint.",
                func = function()
                    eLocal.Heist.Generic.Skip.Old:Set(Bits.SetBit(eLocal.Heist.Generic.Skip.Old:Get(), 17))
                    eLocal.Heist.Generic.Skip.New:Set(Bits.SetBit(eLocal.Heist.Generic.Skip.New:Get(), 17))
                    SilentLogger.LogInfo("[Skip Checkpoint] 检查点已被跳过 ツ")
                end
            },

            Cut = {
                hash = J("SN_Generic_Cut"),
                name = "Self",
                type = eFeatureType.InputInt,
                desc = "Select the cut for yourself.",
                defv = 0,
                lims = { 0, 999 },
                step = 1,
                func = function(ftr)
                    SilentLogger.LogInfo("[Self] 自身分成已更改。别忘了应用 ツ")
                end
            },

            Apply = {
                hash = J("SN_Generic_Apply"),
                name = "Apply Cut",
                type = eFeatureType.Button,
                desc = "Applies the selected cut for yourself.",
                func = function(cut)
                    eGlobal.Heist.Generic.Cut:Set(cut)
                    SilentLogger.LogInfo("[Apply Cut] 分成已应用 ツ")
                end
            }
        },

        Agency = {
            Preps = {
                Contract = {
                    hash = J("SN_Agency_Contract"),
                    name = "Contract",
                    type = eFeatureType.Combo,
                    desc = "Select the desired VIP contract.",
                    list = eTable.Heist.Agency.Contracts,
                    func = function(ftr)
                        local list  = eTable.Heist.Agency.Contracts
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Contract (Agency)] 已选合约: %s ツ", list:GetName(index)))
                    end
                },

                Complete = {
                    hash = J("SN_Agency_Complete"),
                    name = "Apply & Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Applies all changes and completes all preparations.",
                    func = function(contract)
                        eStat.MPX_FIXER_STORY_BS:Set(contract)

                        if contract < 18 then
                            eStat.MPX_FIXER_STORY_STRAND:Set(0)
                        elseif contract < 128 then
                            eStat.MPX_FIXER_STORY_STRAND:Set(1)
                        elseif contract < 2044 then
                            eStat.MPX_FIXER_STORY_STRAND:Set(2)
                        else
                            eStat.MPX_FIXER_STORY_STRAND:Set(-1)
                        end

                        eStat.MPX_FIXER_GENERAL_BS:Set(-1)
                        eStat.MPX_FIXER_COMPLETED_BS:Set(-1)

                        SilentLogger.LogInfo("[Apply & Complete Preps (Agency)] 准备任务已完成 ツ")
                    end
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_Agency_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Agency's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Agency)
                            SilentLogger.LogInfo("[Teleport to Entrance (Agency)] 你已被传送至入口 ツ")
                        end
                    },

                    Computer = {
                        hash = J("SN_Agency_Computer"),
                        name = "Teleport to Computer",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Agency's computer.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Agency))
                            SilentLogger.LogInfo("[Teleport to Computer (Agency)] 你已被传送至电脑 ツ")
                        end
                    },

                    Mission = {
                        hash = J("SN_Agency_Board"),
                        name = "Teleport to Mission",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Agency's mission.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Franklin, nil, true)
                            SilentLogger.LogInfo("[Teleport to Board (Agency)] 你已被传送至任务板 ツ")
                        end
                    }
                },

                Finish = {
                    hash = Utils.Joaat("SN_Agency_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        if CONFIG.instant_finish.agency == 1 then
                            Helper.NewInstantFinishHeist()

                            SilentLogger.LogInfo("[Instant Finish] 抢劫已完成。使用的方法：新方法 ツ")
                            return
                        end

                        GTA.ForceScriptHost(eScript.Heist.New)
                        Script.Yield(1000)
                        eLocal.Heist.Agency.Finish.Step1:Set(51338752)
                        eLocal.Heist.Agency.Finish.Step2:Set(50)

                        SilentLogger.LogInfo("[Instant Finish (Agency)] 抢劫已完成。使用的方法：旧方法 ツ")
                    end
                },

                Cooldown = {
                    hash = J("SN_Agency_Cooldown"),
                    name = "Kill Cooldowns",
                    type = eFeatureType.Button,
                    desc = "Skips the heist's cooldowns. Doesn't skip the cooldown between transactions (20 min).",
                    func = function()
                        eTunable.Heist.Agency.Cooldown.Story:Set(0)
                        eTunable.Heist.Agency.Cooldown.Security:Set(0)
                        eTunable.Heist.Agency.Cooldown.Payphone:Set(0)
                        eStat.MPX_FIXER_STORY_COOLDOWN:Set(-1)
                        SilentLogger.LogInfo("[Kill Cooldowns (Agency)] 冷却时间已清除 ツ")
                    end
                }
            },

            Payout = {
                Select = {
                    hash = J("SN_Agency_Select"),
                    name = "Payout",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired payout.",
                    defv = 0,
                    lims = { 0, 2500000 },
                    step = 100000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Payout (Agency)] 分红已更改。别忘了应用 ツ")
                    end
                },

                Max = {
                    hash = J("SN_Agency_Max"),
                    name = "Max",
                    type = eFeatureType.Button,
                    desc = "Maximizes the payout, but doesn't apply it.",
                    func = function()
                        SilentLogger.LogInfo("[Max (Agency)] 分红已最大化。别忘了应用 ツ")
                    end
                },

                Apply = {
                    hash = J("SN_Agency_Apply"),
                    name = "Apply Payout",
                    type = eFeatureType.Button,
                    desc = "Applies the selected payout. Use after you can see the minimap.",
                    func = function(payout)
                        eTunable.Heist.Agency.Payout:Set(payout)
                        SilentLogger.LogInfo("[Apply Payout (Agency)] 分红已应用 ツ")
                    end
                }
            }
        },

        Apartment = {
            Preps = {
                Complete = {
                    hash = J("SN_Apartment_Complete"),
                    name = "Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Completes all preparations.",
                    func = function()
                        eStat.MPX_HEIST_PLANNING_STAGE:Set(-1)

                        if CONFIG.collab.jinxscript.enabled then
                            Script.LoadSubscribedScript("JinxScript")

                            if FeatureMgr.GetFeatureByHash(eTable.JinxScript.Features.RestartFreemode) then
                                SilentLogger.LogInfo("[Complete Preps (Apartment)] 正在使用 JinxScript 重新启动线上模式 ツ")
                                FeatureMgr.GetFeatureByHash(eTable.JinxScript.Features.RestartFreemode):OnClick()
                                SilentLogger.LogInfo("[Complete Preps (Apartment)] 线上模式已由 JinxScript 重新启动 ツ")
                            else
                                SilentLogger.LogError("[Complete Preps (Apartment)] JinxScript 协作已启用，但脚本未运行 ツ")
                            end

                            if CONFIG.collab.jinxscript.autostop then
                                Script.LoadSubscribedScript("JinxScript", true)
                            end
                        end

                        SilentLogger.LogInfo("[Complete Preps (Apartment)] 准备任务已完成 ツ")
                    end
                },

                Reload = {
                    hash = J("SN_Apartment_Reload"),
                    name = "Redraw Board",
                    type = eFeatureType.Button,
                    desc = "Redraws the planning board.",
                    func = function()
                        eGlobal.Heist.Apartment.Reload:Set(22)
                        SilentLogger.LogInfo("[Redraw Board (Apartment)] 计划板已重绘 ツ")
                    end
                },

                Change = {
                    hash = J("SN_Apartment_Change"),
                    name = "Change Session",
                    type = eFeatureType.Button,
                    desc = "Changes your session to the new one.",
                    func = function()
                        GTA.StartSession(eTable.Session.Types.NewPublic)
                        SilentLogger.LogInfo("[Change Session (Apartment)] 在线战局已更换 ツ")
                    end
                }
            },

            Launch = {
                Solo = {
                    hash = J("SN_Apartment_Launch"),
                    name = "Solo Launch",
                    type = eFeatureType.Toggle,
                    desc = "Allows launching the current heist alone.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if GTA.IsScriptRunning(eScript.Heist.Launcher) then
                                local value = eLocal.Heist.Generic.Launch.Step1:Get()

                                if value ~= 0 then
                                    if ScriptGlobal.GetInt(794954 + 4 + 1 + (value * 95) + 75) > 1 then
                                        ScriptGlobal.SetInt(794954 + 4 + 1 + (value * 95) + 75, 1)
                                    end

                                    if eLocal.Heist.Generic.Launch.Step2:Get() > 1 then
                                        eLocal.Heist.Generic.Launch.Step2:Set(1)
                                    end

                                    eGlobal.Heist.Generic.Launch.Step1:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step2:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step3:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step4:Set(0)

                                    eLocal.Heist.Generic.Launch.Step3:Set(0)
                                    eGlobal.Heist.Generic.Launch.Step5:Set(1)
                                end
                            end

                            if not loggedApartmentLaunch then
                                SilentLogger.LogInfo("[Solo Launch (Apartment)] 抢劫任务已可单人开启 ツ")
                                loggedApartmentLaunch = true
                            end
                        else
                            local isFleeca = eStat.HEIST_MISSION_RCONT_ID_1:Get() == eTable.Heist.Apartment.Heists.FleecaJob

                            ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, (isFleeca) and 2 or 4)
                            eLocal.Heist.Generic.Launch.Step2:Set((isFleeca) and 2 or 4)
                            eGlobal.Heist.Generic.Launch.Step1:Set((isFleeca) and 2 or 4)
                            eGlobal.Heist.Generic.Launch.Step2:Set((isFleeca) and 2 or 4)
                            eGlobal.Heist.Generic.Launch.Step3:Set(1)
                            eGlobal.Heist.Generic.Launch.Step4:Set(0)

                            SilentLogger.LogInfo("[Solo Launch (Apartment)] 抢劫任务已恢复为不可单人开启 ツ")
                            loggedApartmentLaunch = false
                        end
                    end
                },

                Reset = {
                    hash = J("SN_Apartment_LaunchReset"),
                    name = "Reset",
                    type = eFeatureType.Button,
                    desc = "Resets the launch settings for the current heist.",
                    func = function()
                        local isFleeca = eStat.HEIST_MISSION_RCONT_ID_1:Get() == eTable.Heist.Apartment.Heists.FleecaJob

                        ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, (isFleeca) and 2 or 4)
                        eLocal.Heist.Generic.Launch.Step2:Set((isFleeca) and 2 or 4)
                        eGlobal.Heist.Generic.Launch.Step1:Set((isFleeca) and 2 or 4)
                        eGlobal.Heist.Generic.Launch.Step2:Set((isFleeca) and 2 or 4)
                        eGlobal.Heist.Generic.Launch.Step3:Set(1)
                        eGlobal.Heist.Generic.Launch.Step4:Set(0)
                        eLocal.Heist.Generic.Launch.Step3:Set(0)
                        eGlobal.Heist.Generic.Launch.Step5:Set(1)

                        SilentLogger.LogInfo("[Reset (Apartment)] 启动设置已重置 ツ")
                    end
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_Apartment_Teleport"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the closest Apartment's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Apartment)
                            SilentLogger.LogInfo("[Teleport to Entrance (Apartment)] 你已被传送到入口 ツ")
                        end
                    },

                    Board = {
                        hash = J("SN_Apartment_Board"),
                        name = "Teleport to Board",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Apartment's planning board.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Heist, 173.376, true)
                            SilentLogger.LogInfo("[Teleport to Board (Apartment)] 你已被传送到计划板 ツ")
                        end
                    },
                },

                Force = {
                    hash = J("SN_Apartment_Force"),
                    name = "Force Ready",
                    type = eFeatureType.Button,
                    desc = "Forces everyone to be «Ready».",
                    func = function()
                        GTA.ForceScriptHost(eScript.Heist.Old)
                        Script.Yield(1000)

                        for i = 2, 4 do
                            eGlobal.Heist.Apartment.Ready[F("Player%d", i)]:Set(6)
                        end

                        SilentLogger.LogInfo("[Force Ready (Apartment)] 所有人已被强制就绪 ツ")
                    end
                },

                Finish = {
                    hash = J("SN_Apartment_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        if CONFIG.instant_finish.apartment == 1 then
                            Helper.NewInstantFinishHeist()

                            SilentLogger.LogInfo("[Instant Finish (Apartment)] 抢劫已完成。使用的方法：New ツ")
                            return
                        end

                        GTA.ForceScriptHost(eScript.Heist.Old)
                        Script.Yield(1000)

                        local heist = eStat.HEIST_MISSION_RCONT_ID_1:Get()

                        if heist == eTable.Heist.Apartment.Heists.PacificJob then
                            eLocal.Heist.Apartment.Finish.Step2:Set(5)
                            eLocal.Heist.Apartment.Finish.Step3:Set(80)
                            eLocal.Heist.Apartment.Finish.Step4:Set(10000000)
                            eLocal.Heist.Apartment.Finish.Step5:Set(99999)
                            eLocal.Heist.Apartment.Finish.Step6:Set(99999)
                        else
                            eLocal.Heist.Apartment.Finish.Step1:Set(12)
                            eLocal.Heist.Apartment.Finish.Step4:Set(99999)
                            eLocal.Heist.Apartment.Finish.Step5:Set(99999)
                            eLocal.Heist.Apartment.Finish.Step6:Set(99999)
                        end

                        SilentLogger.LogInfo("[Instant Finish (Apartment)] 抢劫已完成。使用的方法：Old ツ")
                    end
                },

                FleecaHack = {
                    hash = J("SN_Apartment_FleecaHack"),
                    name = "Bypass Fleeca Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the hacking process of The Fleeca Job heist.",
                    func = function()
                        eLocal.Heist.Apartment.Bypass.Fleeca.Hack:Set(7)
                        SilentLogger.LogInfo("[Bypass Fleeca Hack (Apartment)] 破解流程已跳过 ツ")
                    end
                },

                FleecaDrill = {
                    hash = J("SN_Apartment_FleecaDrill"),
                    name = "Bypass Fleeca Drill",
                    type = eFeatureType.Button,
                    desc = "Skips the drilling process of The Fleeca Job.",
                    func = function()
                        eLocal.Heist.Apartment.Bypass.Fleeca.Drill:Set(100)
                        SilentLogger.LogInfo("[Bypass Fleeca Drill (Apartment)] 钻孔流程已跳过 ツ")
                    end
                },

                PacificHack = {
                    hash = J("SN_Apartment_PacificHack"),
                    name = "Bypass Pacific Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the hacking process of The Pacific Standard Job heist.",
                    func = function()
                        eLocal.Heist.Apartment.Bypass.Pacific.Hack:Set(9)
                        SilentLogger.LogInfo("[Bypass Pacific Hack (Apartment)] 破解流程已跳过 ツ")
                    end
                },

                Cooldown = {
                    hash = J("SN_Apartment_Cooldown"),
                    name = "Kill Cooldown",
                    type = eFeatureType.Button,
                    desc = "Skips the heist's cooldown. Doesn't skip the cooldown between transactions (20 min).",
                    func = function()
                        eGlobal.Heist.Apartment.Cooldown:Set(-1)
                        SilentLogger.LogInfo("[Kill Cooldown (Apartment)] 冷却时间已清除 ツ")
                    end
                },

                Play = {
                    hash = J("SN_Apartment_Play"),
                    name = "Play Unavailable Jobs",
                    type = eFeatureType.Button,
                    desc = "Allows you to play unavailable jobs temporarily.",
                    func = function()
                        eGlobal.Heist.Apartment.Cooldown:Set(-1)
                        SilentLogger.LogInfo("[Play Unavailable Jobs (Apartment)] 未解锁任务已变为可玩 ツ")
                    end
                },

                Unlock = {
                    hash = J("SN_Apartment_Unlock"),
                    name = "Unlock All Jobs",
                    type = eFeatureType.Button,
                    desc = "Unlocks all jobs without playing every heist one by one. Restart the game to apply.",
                    func = function()
                        eStat.MPX_HEIST_SAVED_STRAND_0:Set(eTunable.Heist.Apartment.RootIdHash.Fleeca:Get())
                        eStat.MPX_HEIST_SAVED_STRAND_0_L:Set(5)
                        eStat.MPX_HEIST_SAVED_STRAND_1:Set(eTunable.Heist.Apartment.RootIdHash.Prison:Get())
                        eStat.MPX_HEIST_SAVED_STRAND_1_L:Set(5)
                        eStat.MPX_HEIST_SAVED_STRAND_2:Set(eTunable.Heist.Apartment.RootIdHash.Humane:Get())
                        eStat.MPX_HEIST_SAVED_STRAND_2_L:Set(5)
                        eStat.MPX_HEIST_SAVED_STRAND_3:Set(eTunable.Heist.Apartment.RootIdHash.Series:Get())
                        eStat.MPX_HEIST_SAVED_STRAND_3_L:Set(5)
                        eStat.MPX_HEIST_SAVED_STRAND_4:Set(eTunable.Heist.Apartment.RootIdHash.Pacific:Get())
                        eStat.MPX_HEIST_SAVED_STRAND_4_L:Set(5)

                        SilentLogger.LogInfo("[Unlock All Jobs (Apartment)] 所有任务已解锁。别忘了重启游戏 ツ")
                    end
                }
            },

            Cuts = {
                Bonus = {
                    hash = J("SN_Apartment_Bonus"),
                    name = "12mil Bonus",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: works only for you, even if not the host.\nAllows you to get 12 millions bonus for The Pacific Standard Job on hard difficulty. Enable before starting the heist. Has a cooldown.",
                    func = function(ftr)
                        eStat.MPPLY_HEISTFLOWORDERPROGRESS:Set((ftr:IsToggled()) and 268435455 or 134217727)
                        eStat.MPPLY_AWD_HST_ORDER:Set(not ftr:IsToggled())
                        eStat.MPPLY_HEISTTEAMPROGRESSBITSET:Set((ftr:IsToggled()) and 268435455 or 134217727)
                        eStat.MPPLY_AWD_HST_SAME_TEAM:Set(not ftr:IsToggled())
                        eStat.MPPLY_HEISTNODEATHPROGREITSET:Set((ftr:IsToggled()) and 268435455 or 134217727)
                        eStat.MPPLY_AWD_HST_ULT_CHAL:Set(not ftr:IsToggled())

                        if ftr:IsToggled() then
                            if not loggedApartmentBonus then
                                SilentLogger.LogInfo("[12mil Bonus (Apartment)] 奖金已生效。别忘了注意难度 ツ")
                                loggedApartmentBonus = true
                            end
                        else
                            SilentLogger.LogInfo("[12mil Bonus (Apartment)] 奖金已取消生效 ツ")
                            loggedApartmentBonus = false
                        end
                    end
                },

                Double = {
                    hash = J("SN_Apartment_Double"),
                    name = "Double Rewards Week",
                    type = eFeatureType.Toggle,
                    desc = "Enable this during double rewards week.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Double Rewards Week (Apartment)] 分红比例已%s ツ", (ftr:IsToggled()) and "降低" or "提高"))
                    end
                },

                Presets = {
                    hash = J("SN_Apartment_Presets"),
                    name = "Presets",
                    type = eFeatureType.Combo,
                    desc = "Select one of the ready-made presets.",
                    list = eTable.Heist.Apartment.Presets,
                    func = function(bool)
                        Helper.SetApartmentMaxPayout(bool)
                    end
                },

                Player1 = {
                    Toggle = {
                        hash = J("SN_Apartment_Player1_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 1.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 1 (Apartment)] 1号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Apartment_Player1"),
                        name = "Player 1",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 1.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 1 (Apartment)] 1号玩家分红已修改。别忘了应用 ツ")
                        end
                    }
                },

                Player2 = {
                    Toggle = {
                        hash = J("SN_Apartment_Player2_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 2.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 2 (Apartment)] 2号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Apartment_Player2"),
                        name = "Player 2",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 2.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 2 (Apartment)] 2号玩家分红已修改。别忘了应用 ツ")
                        end
                    }
                },

                Player3 = {
                    Toggle = {
                        hash = J("SN_Apartment_Player3_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 3.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 3 (Apartment)] 3号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Apartment_Player3"),
                        name = "Player 3",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 3.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 3 (Apartment)] 3号玩家分红已修改。别忘了应用 ツ")
                        end
                    }
                },

                Player4 = {
                    Toggle = {
                        hash = J("SN_Apartment_Player4_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 4.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 4 (Apartment)] 4号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Apartment_Player4"),
                        name = "Player 4",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 4.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 4 (Apartment)] 4号玩家分红已修改。别忘了应用 ツ")
                        end
                    }
                },

                Apply = {
                    hash = J("SN_Apartment_Apply"),
                    name = "Apply Cuts",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: screen «Aspect Ratio» must be «16:9».\nApplies the selected cuts for players.",
                    func = function(cuts)
                        GUI.Toggle()
                        Script.Yield(1000)

                        local function SetCuts()
                            eGlobal.Heist.Apartment.Cut.Player1.Global:Set(100 - (cuts[1] + cuts[2] + cuts[3] + cuts[4]))
                            eGlobal.Heist.Apartment.Cut.Player2.Global:Set(cuts[2])
                            eGlobal.Heist.Apartment.Cut.Player3.Global:Set(cuts[3])
                            eGlobal.Heist.Apartment.Cut.Player4.Global:Set(cuts[4])
                            eNative.PAD.SET_CURSOR_POSITION(0.775, 0.175)
                            GTA.SimulatePlayerControl(237)
                            GTA.SimulateFrontendControl(202)
                        end

                        if cuts[1] ~= 0 and (cuts[2] ~= 0 or cuts[3] ~= 0 or cuts[4] ~= 0) then
                            SetCuts()
                            Script.Yield(1000)
                            eGlobal.Heist.Apartment.Cut.Player1.Local:Set(cuts[1])
                        elseif cuts[1] == 0 then
                            SetCuts()
                            Script.Yield(1000)
                            eGlobal.Heist.Apartment.Cut.Player1.Local:Set(0)
                        else
                            eGlobal.Heist.Apartment.Cut.Player1.Local:Set(cuts[1])
                        end

                        GUI.Toggle()
                        SilentLogger.LogInfo("[Apply Cuts (Apartment)] 分红已应用 ツ")
                    end
                }
            },

            Presets = {
                File = {
                    hash = J("SN_Apartment_File"),
                    name = "File",
                    type = eFeatureType.Combo,
                    desc = "Select the desired preset.",
                    list = eTable.Heist.Apartment.Files,
                    func = function(ftr)
                        local list  = eTable.Heist.Apartment.Files
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[File (Apartment)] 已选择抢劫预设：%s ツ", (list:GetName(index) == "") and "空" or list:GetName(index)))
                    end
                },

                Load = {
                    hash = J("SN_Apartment_Load"),
                    name = "Load",
                    type = eFeatureType.Button,
                    desc = "Loads the selected preset.",
                    func = function(file)
                        local path = F("%s\\%s.json", APART_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            local preps = Json.DecodeFromFile(path)
                            Helper.ApplyApartmentPreset(preps)
                            SilentLogger.LogInfo(F("[Load (Apartment)] 预设«%s»已加载 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Load (Apartment)] 预设«%s»不存在 ツ", (file == "") and "空" or file))
                    end
                },

                Remove = {
                    hash = J("SN_Apartment_Remove"),
                    name = "Remove",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: cannot be undone.\nRemoves the selected preset.",
                    func = function(file)
                        local path = F("%s\\%s.json", APART_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            FileMgr.DeleteFile(path)
                            Helper.RefreshFiles()
                            SilentLogger.LogInfo(F("[Remove (Apartment)] 预设«%s»已移除 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Remove (Apartment)] 预设«%s»不存在 ツ", (file == "") and "空" or file))
                    end
                },

                Refresh = {
                    hash = J("SN_Apartment_Refresh"),
                    name = "Refresh",
                    type = eFeatureType.Button,
                    desc = "Refreshes the list of presets.",
                    func = function()
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo("[Refresh (Apartment)] 抢劫预设已刷新 ツ")
                    end
                },

                Name = {
                    hash = J("SN_Apartment_Name"),
                    name = "QuickPreset",
                    type = eFeatureType.InputText,
                    desc = "Input the desired preset name."
                },

                Save = {
                    hash = J("SN_Apartment_Save"),
                    name = "Save",
                    type = eFeatureType.Button,
                    desc = "Saves the current heist preset to the file.",
                    func = function(file, preps)
                        local path = F("%s\\%s.json", APART_DIR, file)
                        FileMgr.CreateHeistPresetsDirs()
                        Json.EncodeToFile(path, preps)
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo(F("[Save (Apartment)] 预设«%s»已保存 ツ", file))
                    end
                },

                Copy = {
                    hash = J("SN_Apartment_Copy"),
                    name = "Copy Folder Path",
                    type = eFeatureType.Button,
                    desc = "Copies the presets folder path to the clipboard.",
                    func = function()
                        FileMgr.CreateHeistPresetsDirs()
                        ImGui.SetClipboardText(APART_DIR)
                        SilentLogger.LogInfo("[Copy Folder Path (Apartment)] 预设文件夹路径已复制 ツ")
                    end
                }
            }
        },

        AutoShop = {
            Preps = {
                Contract = {
                    hash = J("SN_AutoShop_Contract"),
                    name = "Contract",
                    type = eFeatureType.Combo,
                    desc = "Select the desired contract.",
                    list = eTable.Heist.AutoShop.Contracts,
                    func = function(ftr)
                        local list  = eTable.Heist.AutoShop.Contracts
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Contract (Auto Shop)] 已选择合约：%s ツ", list:GetName(index)))
                    end
                },

                Complete = {
                    hash = J("SN_AutoShop_Complete"),
                    name = "Apply & Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Applies all changes and completes all preparations. Also, redraws the planning board.",
                    func = function(contract)
                        eStat.MPX_TUNER_CURRENT:Set(contract)
                        eStat.MPX_TUNER_GEN_BS:Set((contract == 1) and 4351 or 12543)
                        eLocal.Heist.AutoShop.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply & Complete Preps (Auto Shop)] 前置准备已完成 ツ")
                    end
                },

                Reset = {
                    hash = J("SN_AutoShop_Reset"),
                    name = "Reset Preps",
                    type = eFeatureType.Button,
                    desc = "Resets all preparations. Also, redraws the planning board.",
                    func = function()
                        eStat.MPX_TUNER_GEN_BS:Set(12467)
                        eLocal.Heist.AutoShop.Reload:Set(2)
                        SilentLogger.LogInfo("[Reset Preps (Auto Shop)] 所有准备步骤已重置 ツ")
                    end
                },

                Reload = {
                    hash = J("SN_AutoShop_Reload"),
                    name = "Redraw Board",
                    type = eFeatureType.Button,
                    desc = "Redraws the planning board.",
                    func = function()
                        eLocal.Heist.AutoShop.Reload:Set(2)
                        SilentLogger.LogInfo("[Redraw Board (Auto Shop)] 规划板已重新绘制 ツ")
                    end
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_AutoShop_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Auto Shop's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.AutoShop)
                            SilentLogger.LogInfo("[Teleport to Entrance (Auto Shop)] 你已被传送至改装铺入口 ツ")
                        end
                    },

                    Board = {
                        hash = J("SN_AutoShop_Board"),
                        name = "Teleport to Board",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Auto Shop's planning board.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.AutoShop))
                            SilentLogger.LogInfo("[Teleport to Board (Auto Shop)] 你已被传送至改装铺规划板处 ツ")
                        end
                    }
                },

                Finish = {
                    hash = Utils.Joaat("SN_AutoShop_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        if CONFIG.instant_finish.auto_shop == 1 then
                            Helper.NewInstantFinishHeist()

                            SilentLogger.LogInfo("[Instant Finish (Auto Shop)] 抢劫任务已完成。使用的方法：新式 ツ")
                            return
                        end

                        GTA.ForceScriptHost(eScript.Heist.New)
                        Script.Yield(1000)
                        eLocal.Heist.AutoShop.Finish.Step1:Set(51338977)
                        eLocal.Heist.AutoShop.Finish.Step2:Set(101)

                        SilentLogger.LogInfo("[Instant Finish (Auto Shop)] 抢劫任务已完成。使用的方法：旧式 ツ")
                    end
                },

                Cooldown = {
                    hash = J("SN_AutoShop_Cooldown"),
                    name = "Kill Cooldown",
                    type = eFeatureType.Button,
                    desc = "Skips the heist's cooldown. Doesn't skip the cooldown between transactions (20 min).",
                    func = function()
                        for i = 0, 7 do
                            eStat[F("MPX_TUNER_CONTRACT%d_POSIX", i)]:Set(0)
                        end

                        eTunable.Heist.AutoShop.Cooldown:Set(0)

                        SilentLogger.LogInfo("[Kill Cooldown (Auto Shop)] 冷却时间已清除 ツ")
                    end
                }
            },

            Payout = {
                Select = {
                    hash = J("SN_AutoShop_Select"),
                    name = "Payout",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired payout.",
                    defv = 0,
                    lims = { 0, 2000000 },
                    step = 100000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Payout (Auto Shop)] 奖励金额已更改。别忘了应用更改 ツ")
                    end
                },

                Max = {
                    hash = J("SN_AutoShop_Max"),
                    name = "Max",
                    type = eFeatureType.Button,
                    desc = "Maximizes the payout, but doesn't apply it.",
                    func = function()
                        SilentLogger.LogInfo("[Max (Auto Shop)] 奖励金额已调至最大值。别忘了应用更改 ツ")
                    end
                },

                Apply = {
                    hash = J("SN_AutoShop_Apply"),
                    name = "Apply Payout",
                    type = eFeatureType.Button,
                    desc = "Applies the selected payout. Use after you can see the minimap.",
                    func = function(payout)
                        eTunable.Heist.AutoShop.Payout.First:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Second:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Third:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Fourth:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Fifth:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Sixth:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Seventh:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Eight:Set(payout)
                        eTunable.Heist.AutoShop.Payout.Fee:Set(0.0)
                        SilentLogger.LogInfo("[Apply Payout (Auto Shop)] 奖励金额已生效 ツ")
                    end
                }
            }
        },

        CayoPerico = {
            Preps = {
                Difficulty = {
                    hash = J("SN_CayoPerico_Difficulty"),
                    name = "Difficulty",
                    type = eFeatureType.Combo,
                    desc = "Select the desired difficulty.",
                    list = eTable.Heist.CayoPerico.Difficulties,
                    func = function(ftr)
                        local list  = eTable.Heist.CayoPerico.Difficulties
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Difficulty (Cayo Perico)] 已选择难度：%s ツ", list:GetName(index)))
                    end
                },

                Approach = {
                    hash = J("SN_CayoPerico_Approach"),
                    name = "Approach",
                    type = eFeatureType.Combo,
                    desc = "Select the desired approach.",
                    list = eTable.Heist.CayoPerico.Approaches,
                    func = function(ftr)
                        local list  = eTable.Heist.CayoPerico.Approaches
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Approach (Cayo Perico)] 已选择潜入方式：%s ツ", list:GetName(index)))
                    end
                },

                Loadout = {
                    hash = J("SN_CayoPerico_Loadout"),
                    name = "Loadout",
                    type = eFeatureType.Combo,
                    desc = "Select the desired loadout.",
                    list = eTable.Heist.CayoPerico.Loadouts,
                    func = function(ftr)
                        local list  = eTable.Heist.CayoPerico.Loadouts
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Loadout (Cayo Perico)] 已选择装备配置：%s ツ", list:GetName(index)))
                    end
                },

                Target = {
                    Primary = {
                        hash = J("SN_CayoPerico_PrimaryTarget"),
                        name = "Target",
                        type = eFeatureType.Combo,
                        desc = "Select the desired primary target.",
                        list = eTable.Heist.CayoPerico.Targets.Primary,
                        func = function(ftr)
                            local list  = eTable.Heist.CayoPerico.Targets.Primary
                            local index = list[ftr:GetListIndex() + 1].index
                            SilentLogger.LogInfo(F("[Primary Target (Cayo Perico)] 已选择主要目标：%s ツ", list:GetName(index)))
                        end
                    },

                    Secondary = {
                        Compound = {
                            hash = J("SN_CayoPerico_CompoundTarget"),
                            name = "Com. Target",
                            type = eFeatureType.Combo,
                            desc = "Select the desired compound target.",
                            list = eTable.Heist.CayoPerico.Targets.Secondary,
                            func = function(ftr)
                                local list  = eTable.Heist.CayoPerico.Targets.Secondary
                                local index = list[ftr:GetListIndex() + 1].index
                                SilentLogger.LogInfo(F("[Compound Target (Cayo Perico)] 已选择庄园目标：%s ツ", list:GetName(index)))
                            end
                        },

                        Island = {
                            hash = J("SN_CayoPerico_IslandTarget"),
                            name = "Isl. Target",
                            type = eFeatureType.Combo,
                            desc = "Select the desired island target.",
                            list = eTable.Heist.CayoPerico.Targets.Secondary,
                            func = function(ftr)
                                local list  = eTable.Heist.CayoPerico.Targets.Secondary
                                local index = list[ftr:GetListIndex() + 1].index
                                SilentLogger.LogInfo(F("[Island Target (Cayo Perico)] 已选择岛屿目标：%s ツ", list:GetName(index)))
                            end
                        }
                    },

                    Amount = {
                        Compound = {
                            hash = J("SN_CayoPerico_CompoundAmount"),
                            name = "Com. Amount",
                            type = eFeatureType.Combo,
                            desc = "Select the desired compound target amount.",
                            list = eTable.Heist.CayoPerico.Targets.Amounts.Compound,
                            func = function(ftr)
                                local list  = eTable.Heist.CayoPerico.Targets.Amounts.Compound
                                local index = list[ftr:GetListIndex() + 1].index
                                SilentLogger.LogInfo(F("[Compound Amount (Cayo Perico)] 已选择庄园目标数量：%s ツ", list:GetName(index)))
                            end
                        },

                        Island = {
                            hash = J("SN_CayoPerico_IslandAmount"),
                            name = "Isl. Amount",
                            type = eFeatureType.Combo,
                            desc = "Select the desired island target amount.",
                            list = eTable.Heist.CayoPerico.Targets.Amounts.Island,
                            func = function(ftr)
                                local list  = eTable.Heist.CayoPerico.Targets.Amounts.Island
                                local index = list[ftr:GetListIndex() + 1].index
                                SilentLogger.LogInfo(F("[Island Amount (Cayo Perico)] 已选择岛屿目标数量：%s ツ", list:GetName(index)))
                            end
                        },

                        Arts = {
                            hash = J("SN_CayoPerico_ArtsAmount"),
                            name = "Arts Amount",
                            type = eFeatureType.Combo,
                            desc = "Select the desired compound arts amount.",
                            list = eTable.Heist.CayoPerico.Targets.Amounts.Arts,
                            func = function(ftr)
                                local list  = eTable.Heist.CayoPerico.Targets.Amounts.Arts
                                local index = list[ftr:GetListIndex() + 1].index
                                SilentLogger.LogInfo(F("[Arts Amount (Cayo Perico)] 已选择艺术品数量：%s ツ", list:GetName(index)))
                            end
                        }
                    },

                    Value = {
                        Default = {
                            hash = J("SN_CayoPerico_DefaultValue"),
                            name = "Default",
                            type = eFeatureType.Button,
                            desc = "Resets the values to default.",
                            func = function()
                                SilentLogger.LogInfo("[Default (Cayo Perico)] 数值已重置为默认值 ツ")
                            end
                        },

                        Cash = {
                            hash = J("SN_CayoPerico_CashValue"),
                            name = "Cash Value",
                            type = eFeatureType.InputInt,
                            desc = "Select the desired cash value.",
                            defv = eTable.Heist.CayoPerico.Values.Cash,
                            lims = { 0, 2550000 },
                            step = 50000,
                            func = function()
                                SilentLogger.LogInfo("[Cash Value (Cayo Perico)] 现金价值已更改。别忘了应用更改 ツ")
                            end
                        },

                        Weed = {
                            hash = J("SN_CayoPerico_WeedValue"),
                            name = "Weed Value",
                            type = eFeatureType.InputInt,
                            desc = "Select the desired weed value.",
                            defv = eTable.Heist.CayoPerico.Values.Weed,
                            lims = { 0, 2550000 },
                            step = 50000,
                            func = function()
                                SilentLogger.LogInfo("[Weed Value (Cayo Perico)] 大麻价值已更改。别忘了应用更改 ツ")
                            end
                        },

                        Coke = {
                            hash = J("SN_CayoPerico_CokeValue"),
                            name = "Coke Value",
                            type = eFeatureType.InputInt,
                            desc = "Select the desired coke value.",
                            defv = eTable.Heist.CayoPerico.Values.Coke,
                            lims = { 0, 2550000 },
                            step = 50000,
                            func = function()
                                SilentLogger.LogInfo("[Coke Value (Cayo Perico)] 可卡因价值已更改。别忘了应用更改 ツ")
                            end
                        },

                        Gold = {
                            hash = J("SN_CayoPerico_GoldValue"),
                            name = "Gold Value",
                            type = eFeatureType.InputInt,
                            desc = "Select the desired gold value.",
                            defv = eTable.Heist.CayoPerico.Values.Gold,
                            lims = { 0, 2550000 },
                            step = 50000,
                            func = function()
                                SilentLogger.LogInfo("[Gold Value (Cayo Perico)] 黄金价值已更改。别忘了应用更改 ツ")
                            end
                        },

                        Arts = {
                            hash = J("SN_CayoPerico_ArtsValue"),
                            name = "Arts Value",
                            type = eFeatureType.InputInt,
                            desc = "Select the desired arts value.",
                            defv = eTable.Heist.CayoPerico.Values.Arts,
                            lims = { 0, 2550000 },
                            step = 50000,
                            func = function()
                                SilentLogger.LogInfo("[Arts Value (Cayo Perico)] 艺术品价值已更改。别忘了应用更改 ツ")
                            end
                        }
                    }
                },

                Advanced = {
                    hash = J("SN_CayoPerico_Advanced"),
                    name = "Advanced",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: for advanced users.\nAllows you to change the value of secondary targets.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Advanced (Cayo Perico)] 高级模式已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                    end
                },

                Complete = {
                    hash = J("SN_CayoPerico_Complete"),
                    name = "Apply & Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Applies all changes and completes all preparations. Also, reloads the planning screen.",
                    func = function(difficulty, approach, loadout, primaryTarget, compoundTarget, compoundAmount, artsAmount, islandTarget, islandAmount, advanced, cashValue, weedValue, cokeValue, goldValue, artsValue)
                        if CONFIG.unlock_all_poi.cayo_perico then
                            eStat.MPX_H4CNF_BS_GEN:Set(-1)
                            eStat.MPX_H4CNF_BS_ENTR:Set(63)
                            eStat.MPX_H4CNF_BS_ABIL:Set(63)
                            eStat.MPX_H4CNF_APPROACH:Set(-1)
                            eStat.MPX_H4_PLAYTHROUGH_STATUS:Set(10)
                        end

                        eStat.MPX_H4_PROGRESS:Set(difficulty)
                        eStat.MPX_H4_MISSIONS:Set(approach)
                        eStat.MPX_H4CNF_WEAPONS:Set(loadout)
                        eStat.MPX_H4CNF_TARGET:Set(primaryTarget)
                        eStat.MPX_H4LOOT_CASH_C:Set((eStat.MPX_H4LOOT_CASH_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_CASH_C_SCOPED:Set((eStat.MPX_H4LOOT_CASH_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_WEED_C:Set((eStat.MPX_H4LOOT_WEED_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_WEED_C_SCOPED:Set((eStat.MPX_H4LOOT_WEED_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_COKE_C:Set((eStat.MPX_H4LOOT_COKE_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_COKE_C_SCOPED:Set((eStat.MPX_H4LOOT_COKE_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_GOLD_C:Set((eStat.MPX_H4LOOT_GOLD_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_GOLD_C_SCOPED:Set((eStat.MPX_H4LOOT_GOLD_C.stat:find(compoundTarget)) and compoundAmount or 0)
                        eStat.MPX_H4LOOT_PAINT:Set((artsAmount ~= 0) and artsAmount or 0)
                        eStat.MPX_H4LOOT_PAINT_SCOPED:Set((artsAmount ~= 0) and artsAmount or 0)
                        eStat.MPX_H4LOOT_CASH_I:Set((eStat.MPX_H4LOOT_CASH_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_CASH_I_SCOPED:Set((eStat.MPX_H4LOOT_CASH_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_WEED_I:Set((eStat.MPX_H4LOOT_WEED_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_WEED_I_SCOPED:Set((eStat.MPX_H4LOOT_WEED_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_COKE_I:Set((eStat.MPX_H4LOOT_COKE_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_COKE_I_SCOPED:Set((eStat.MPX_H4LOOT_COKE_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_GOLD_I:Set((eStat.MPX_H4LOOT_GOLD_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_GOLD_I_SCOPED:Set((eStat.MPX_H4LOOT_GOLD_I.stat:find(islandTarget)) and islandAmount or 0)
                        eStat.MPX_H4LOOT_CASH_V:Set((compoundTarget ~= 0 or islandTarget ~= 0) and cashValue or 0)
                        eStat.MPX_H4LOOT_WEED_V:Set((compoundTarget ~= 0 or islandTarget ~= 0) and weedValue or 0)
                        eStat.MPX_H4LOOT_COKE_V:Set((compoundTarget ~= 0 or islandTarget ~= 0) and cokeValue or 0)
                        eStat.MPX_H4LOOT_GOLD_V:Set((compoundTarget ~= 0 or islandTarget ~= 0) and goldValue or 0)
                        eStat.MPX_H4LOOT_PAINT_V:Set((artsAmount ~= 0) and artsValue or 0)
                        eStat.MPX_H4CNF_UNIFORM:Set(-1)
                        eStat.MPX_H4CNF_GRAPPEL:Set(-1)
                        eStat.MPX_H4CNF_TROJAN:Set(5)
                        eStat.MPX_H4CNF_WEP_DISRP:Set(3)
                        eStat.MPX_H4CNF_ARM_DISRP:Set(3)
                        eStat.MPX_H4CNF_HEL_DISRP:Set(3)

                        eLocal.Heist.CayoPerico.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply & Complete Preps (Cayo Perico)] 所有准备步骤已完成 ツ")
                    end
                },

                Reset = {
                    hash = J("SN_CayoPerico_Reset"),
                    name = "Reset Preps",
                    type = eFeatureType.Button,
                    desc = "Resets all preparations. Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_H4_PROGRESS:Set(0)
                        eStat.MPX_H4_MISSIONS:Set(0)
                        eStat.MPX_H4CNF_APPROACH:Set(0)
                        eStat.MPX_H4CNF_TARGET:Set(-1)
                        eStat.MPX_H4CNF_BS_GEN:Set(0)
                        eStat.MPX_H4CNF_BS_ENTR:Set(0)
                        eStat.MPX_H4CNF_BS_ABIL:Set(0)
                        eStat.MPX_H4_PLAYTHROUGH_STATUS:Set(0)
                        eLocal.Heist.CayoPerico.Reload:Set(2)
                        SilentLogger.LogInfo("[Reset Preps (Cayo Perico)] 所有准备步骤已重置 ツ")
                    end
                },

                Reload = {
                    hash = J("SN_CayoPerico_Reload"),
                    name = "Reload Screen",
                    type = eFeatureType.Button,
                    desc = "Reloads the planning screen.",
                    func = function()
                        eLocal.Heist.CayoPerico.Reload:Set(2)
                        SilentLogger.LogInfo("[Reload Screen (Cayo Perico)] 规划界面已重新加载 ツ")
                    end
                }
            },

            Launch = {
                Reset = {
                    hash = J("SN_CayoPerico_LaunchReset"),
                    name = "Reset",
                    type = eFeatureType.Button,
                    desc = "Resets the launch settings for the current heist.",
                    func = function()
                        ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, 1)
                        eLocal.Heist.Generic.Launch.Step2:Set(1)
                        eGlobal.Heist.Generic.Launch.Step1:Set(1)
                        eGlobal.Heist.Generic.Launch.Step2:Set(1)
                        eGlobal.Heist.Generic.Launch.Step3:Set(1)
                        eGlobal.Heist.Generic.Launch.Step4:Set(0)
                        eLocal.Heist.Generic.Launch.Step3:Set(0)
                        eGlobal.Heist.Generic.Launch.Step5:Set(1)

                        SilentLogger.LogInfo("[Reset (Cayo Perico)] 启动设置已重置 ツ")
                    end
                }
            },

            Misc = {
                Teleport = {
                    hash = J("SN_CayoPerico_Teleport"),
                    name = "Teleport to Kosatka",
                    type = eFeatureType.Button,
                    desc = "Teleports you to the Kosatka.",
                    func = function()
                        local function IsKosatkaInOcean()
                            return Bits.IsBitSet(eGlobal.World.Kosatka.Status:Get(), 31)
                        end

                        local entity = GTA.PointerToHandle(GTA.GetLocalPed())
                        eNative.ENTITY.FREEZE_ENTITY_POSITION(entity, true)

                        if GTA.IsInInterior() then
                            GTA.TeleportXYZ(U(eTable.Teleports.MazeBank))
                        end

                        if not IsKosatkaInOcean() then
                            SilentLogger.LogInfo("[Teleport to Kosatka (Cayo Perico)] 科萨卡潜艇不在海域中。正在请求调派... ツ")

                            while not IsKosatkaInOcean() do
                                eGlobal.World.Kosatka.Request:Set(1)
                                Script.Yield()
                            end
                        end

                        GTA.TeleportXYZ(U(eTable.Teleports.Kosatka))

                        while eNative.HUD.GET_CLOSEST_BLIP_INFO_ID(eTable.BlipSprites.Heist) == 0 do
                            Script.Yield()
                        end

                        eNative.ENTITY.FREEZE_ENTITY_POSITION(entity, false)

                        SilentLogger.LogInfo("[Teleport to Kosatka (Cayo Perico)] 你已被传送至科萨卡潜艇处 ツ")
                    end
                },

                Force = {
                    hash = J("SN_CayoPerico_Force"),
                    name = "Force Ready",
                    type = eFeatureType.Button,
                    desc = "Forces everyone to be «Ready».",
                    func = function()
                        GTA.ForceScriptHost(eScript.Heist.New)
                        Script.Yield(1000)

                        for i = 2, 4 do
                            eGlobal.Heist.CayoPerico.Ready[F("Player%d", i)]:Set(1)
                        end

                        SilentLogger.LogInfo("[Force Ready (Cayo Perico)] 已强制所有人进入就绪状态 ツ")
                    end
                },

                Finish = {
                    hash = Utils.Joaat("SN_CayoPerico_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        if CONFIG.instant_finish.cayo_perico == 1 then
                            Helper.NewInstantFinishHeist()

                            SilentLogger.LogInfo("[Instant Finish (Cayo Perico)] 抢劫任务已完成。使用的方法：新式 ツ")
                            return
                        end

                        GTA.ForceScriptHost(eScript.Heist.New)
                        Script.Yield(1000)
                        eLocal.Heist.CayoPerico.Finish.Step1:Set(9)
                        eLocal.Heist.CayoPerico.Finish.Step2:Set(50)

                        SilentLogger.LogInfo("[Instant Finish (Cayo Perico)] 抢劫任务已完成。使用的方法：旧式 ツ")
                    end
                },

                FingerprintHack = {
                    hash = J("SN_CayoPerico_FingerprintHack"),
                    name = "Bypass Fingerprint Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the fingerprint hacking process.",
                    func = function()
                        eLocal.Heist.CayoPerico.Bypass.FingerprintHack:Set(5)
                        SilentLogger.LogInfo("[Bypass Fingerprint Hack (Cayo Perico)] 指纹破解流程已跳过 ツ")
                    end
                },

                PlasmaCutterCut = {
                    hash = J("SN_CayoPerico_PlasmaCutterCut"),
                    name = "Bypass Plasma Cutter Cut",
                    type = eFeatureType.Button,
                    desc = "Skips the cutting process.",
                    func = function()
                        eLocal.Heist.CayoPerico.Bypass.PlasmaCutterCut:Set(100)
                        SilentLogger.LogInfo("[Bypass Plasma Cutter Cut (Cayo Perico)] 等离子切割流程已跳过 ツ")
                    end
                },

                DrainagePipeCut = {
                    hash = J("SN_CayoPerico_DrainagePipeCut"),
                    name = "Bypass Drainage Pipe Cut",
                    type = eFeatureType.Button,
                    desc = "Skips the cutting process.",
                    func = function()
                        eLocal.Heist.CayoPerico.Bypass.DrainagePipeCut:Set(6)
                        SilentLogger.LogInfo("[Bypass Drainage Pipe Cut (Cayo Perico)] 排水管切割流程已跳过 ツ")
                    end
                },

                Bag = {
                    hash = J("SN_CayoPerico_Bag"),
                    name = "Woman's Bag",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: the transaction limit is 2.55mil.\nIncreases the size of the bag.",
                    func = function(ftr)
                        if GTA.IsInSession() then
                            if ftr:IsToggled() then
                                eTunable.Heist.CayoPerico.Bag.MaxCapacity:Set(99999)

                                if not loggedCayoBag then
                                    SilentLogger.LogInfo("[Woman's Bag (Cayo Perico)] 背包容量已增大 ツ")
                                    loggedCayoBag = true
                                end
                            else
                                eTunable.Heist.CayoPerico.Bag.MaxCapacity:Reset()

                                SilentLogger.LogInfo("[Woman's Bag (Cayo Perico)] 背包容量已重置 ツ")
                                loggedCayoBag = false
                            end
                        end
                    end
                },

                Cooldown = {
                    Solo = {
                        hash = J("SN_CayoPerico_SoloCooldown"),
                        name = "Kill Cooldown (after solo)",
                        type = eFeatureType.Button,
                        desc = "Skips the heist's cooldown after you have played solo. Doesn't skip the cooldown between transactions (20 min). Go offline and online after using.",
                        func = function()
                            eStat.MPX_H4_TARGET_POSIX:Set(1659643454)
                            eStat.MPX_H4_COOLDOWN:Set(0)
                            eStat.MPX_H4_COOLDOWN_HARD:Set(0)
                            SilentLogger.LogInfo("[Kill Cooldown (Cayo Perico)] 冷却时间已清除 ツ")
                        end
                    },

                    Team = {
                        hash = J("SN_CayoPerico_TeamCooldown"),
                        name = "Kill Cooldown (after team)",
                        type = eFeatureType.Button,
                        desc = "Skips the heist's cooldown after you have played with a team. Doesn't skip the cooldown between transactions (20 min). Go offline and online after using.",
                        func = function()
                            eStat.MPX_H4_TARGET_POSIX:Set(1659429119)
                            eStat.MPX_H4_COOLDOWN:Set(0)
                            eStat.MPX_H4_COOLDOWN_HARD:Set(0)
                            SilentLogger.LogInfo("[Kill Cooldown (Cayo Perico)] 冷却时间已清除 ツ")
                        end
                    },

                    Offline = {
                        hash = J("SN_CayoPerico_Offline"),
                        name = "Go Offline",
                        type = eFeatureType.Button,
                        desc = "Leaves from GTA Online.",
                        func = function()
                            eGlobal.Session.Switch:Set(1)
                            eGlobal.Session.Quit:Set(-1)
                            SilentLogger.LogInfo("[Go Offline (Cayo Perico)] 已加载离线模式 ツ")
                        end
                    },

                    Online = {
                        hash = J("SN_CayoPerico_Online"),
                        name = "Go Online",
                        type = eFeatureType.Button,
                        desc = "Connects to GTA Online.",
                        func = function()
                            GTA.StartSession(eTable.Session.Types.NewPublic)
                            SilentLogger.LogInfo("[Go Online (Cayo Perico)] 已加载在线模式 ツ")
                        end
                    }
                }
            },

            Cuts = {
                Crew = {
                    hash = J("SN_CayoPerico_Crew"),
                    name = "Remove Crew Cuts",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: cannot be used with «2.55mil Payout».\nRemoves fencing fee and Pavel's cut.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            eTunable.Heist.CayoPerico.Cut.Pavel:Set(0)
                            eTunable.Heist.CayoPerico.Cut.Fee:Set(0)

                            if not loggedCayoCrew then
                                SilentLogger.LogInfo("[Remove Crew Cuts (Cayo Perico)] 团队抽成已移除 ツ")
                                loggedCayoCrew = true
                            end
                        else
                            eTunable.Heist.CayoPerico.Cut.Pavel:Reset()
                            eTunable.Heist.CayoPerico.Cut.Fee:Reset()
                            SilentLogger.LogInfo("[Remove Crew Cuts (Cayo Perico)] 团队抽成已重置 ツ")
                            loggedCayoCrew = false
                        end
                    end
                },

                Presets = {
                    hash = J("SN_CayoPerico_Presets"),
                    name = "Presets",
                    type = eFeatureType.Combo,
                    desc = "ATTENTION: «2.55mil Payout» works only if you've set the «Difficulty» through the script and you don't have any «Secondary Targets».\nSelect one of the ready-made presets.",
                    list = eTable.Heist.CayoPerico.Presets,
                    func = function()
                        Helper.SetCayoMaxPayout()
                        Script.Yield()
                    end
                },

                Player1 = {
                    Toggle = {
                        hash = J("SN_CayoPerico_Player1_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 1.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 1 (Cayo Perico)] 1号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_CayoPerico_Player1_Cut"),
                        name = "Player 1",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 1.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 1 (Cayo Perico)] 1号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player2 = {
                    Toggle = {
                        hash = J("SN_CayoPerico_Player2_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 2.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 2 (Cayo Perico)] 2号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_CayoPerico_Player2_Cut"),
                        name = "Player 2",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 2.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 2 (Cayo Perico)] 2号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player3 = {
                    Toggle = {
                        hash = J("SN_CayoPerico_Player3_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 3.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 3 (Cayo Perico)] 3号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_CayoPerico_Player3_Cut"),
                        name = "Player 3",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 3.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 3 (Cayo Perico)] 3号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player4 = {
                    Toggle = {
                        hash = J("SN_CayoPerico_Player4_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 4.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 4 (Cayo Perico)] 4号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_CayoPerico_Player4_Cut"),
                        name = "Player 4",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 4.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 4 (Cayo Perico)] 4号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Apply = {
                    hash = J("SN_CayoPerico_Apply"),
                    name = "Apply Cuts",
                    type = eFeatureType.Button,
                    desc = "Applies the selected cuts for players.",
                    func = function(cuts)
                        for i = 1, 4 do
                            eGlobal.Heist.CayoPerico.Cut[F("Player%d", i)]:Set(cuts[i])
                        end
                        SilentLogger.LogInfo("[Apply Cuts (Cayo Perico)] 分红已修改 ツ")
                    end
                }
            },

            Presets = {
                File = {
                    hash = J("SN_CayoPerico_File"),
                    name = "File",
                    type = eFeatureType.Combo,
                    desc = "Select the desired preset.",
                    list = eTable.Heist.CayoPerico.Files,
                    func = function(ftr)
                        local list  = eTable.Heist.CayoPerico.Files
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[File (Cayo Perico)] 已选择抢劫任务预设：%s ツ", (list:GetName(index) == "") and "空预设" or list:GetName(index)))
                    end
                },

                Load = {
                    hash = J("SN_CayoPerico_Load"),
                    name = "Load",
                    type = eFeatureType.Button,
                    desc = "Loads the selected preset, but doesn't complete preparations.",
                    func = function(file)
                        local path = F("%s\\%s.json", CAYO_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            local preps = Json.DecodeFromFile(path)
                            Helper.ApplyCayoPreset(preps)
                            SilentLogger.LogInfo(F("[Load (Cayo Perico)] 预设«%s»已加载 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Load (Cayo Perico)] 预设«%s»不存在 ツ", (file == "") and "空预设" or file))
                    end
                },

                Remove = {
                    hash = J("SN_CayoPerico_Remove"),
                    name = "Remove",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: cannot be undone.\nRemoves the selected preset.",
                    func = function(file)
                        local path = F("%s\\%s.json", CAYO_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            FileMgr.DeleteFile(path)
                            Helper.RefreshFiles()
                            SilentLogger.LogInfo(F("[Remove (Cayo Perico)] 预设«%s»已删除 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Remove (Cayo Perico)] 预设«%s»不存在 ツ", (file == "") and "空预设" or file))
                    end
                },

                Refresh = {
                    hash = J("SN_CayoPerico_Refresh"),
                    name = "Refresh",
                    type = eFeatureType.Button,
                    desc = "Refreshes the list of presets.",
                    func = function()
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo("[Refresh (Cayo Perico)] 抢劫任务预设列表已刷新 ツ")
                    end
                },

                Name = {
                    hash = J("SN_CayoPerico_Name"),
                    name = "QuickPreset",
                    type = eFeatureType.InputText,
                    desc = "Input the desired preset name."
                },

                Save = {
                    hash = J("SN_CayoPerico_Save"),
                    name = "Save",
                    type = eFeatureType.Button,
                    desc = "Saves the current heist preset to the file.",
                    func = function(file, preps)
                        local path = F("%s\\%s.json", CAYO_DIR, file)
                        FileMgr.CreateHeistPresetsDirs()
                        Json.EncodeToFile(path, preps)
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo(F("[Save (Cayo Perico)] 预设«%s»已保存 ツ", file))
                    end
                },

                Copy = {
                    hash = J("SN_CayoPerico_Copy"),
                    name = "Copy Folder Path",
                    type = eFeatureType.Button,
                    desc = "Copies the presets folder path to the clipboard.",
                    func = function()
                        FileMgr.CreateHeistPresetsDirs()
                        ImGui.SetClipboardText(CAYO_DIR)
                        SilentLogger.LogInfo("[Copy Folder Path (Cayo Perico)] 预设文件夹路径已复制到剪贴板 ツ")
                    end
                }
            }
        },

        DiamondCasino = {
            Preps = {
                Difficulty = {
                    hash = J("SN_DiamondCasino_Difficulty"),
                    name = "Difficulty",
                    type = eFeatureType.Combo,
                    desc = "ATTENTION: unstable when paired with «Solo Launch».\nSelect the desired difficulty.",
                    list = eTable.Heist.DiamondCasino.Difficulties,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Difficulties
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Difficulty (Diamond Casino)] 已选择难度：%s ツ", list:GetName(index)))
                    end
                },

                Approach = {
                    hash = J("SN_DiamondCasino_Approach"),
                    name = "Approach",
                    type = eFeatureType.Combo,
                    desc = "Select the desired approach.",
                    list = eTable.Heist.DiamondCasino.Approaches,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Approaches
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Approach (Diamond Casino)] 已选择潜入方式：%s ツ", list:GetName(index)))
                    end
                },

                Gunman = {
                    hash = J("SN_DiamondCasino_Gunman"),
                    name = "Gunman",
                    type = eFeatureType.Combo,
                    desc = "Select the desired gunman.",
                    list = eTable.Heist.DiamondCasino.Gunmans,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Gunmans
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Gunman (Diamond Casino)] 已选择枪手：%s ツ", list:GetName(index)))
                    end
                },

                Loadout = {
                    hash = J("SN_DiamondCasino_Loadout"),
                    name = "Loadout",
                    type = eFeatureType.Combo,
                    desc = "Select the desired loadout.",
                    list = eTable.Heist.DiamondCasino.Loadouts,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Loadouts
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Loadout (Diamond Casino)] 已选择装备配置：%s ツ", list:GetName(index)))
                    end
                },

                Driver = {
                    hash = J("SN_DiamondCasino_Driver"),
                    name = "Driver",
                    type = eFeatureType.Combo,
                    desc = "Select the desired driver.",
                    list = eTable.Heist.DiamondCasino.Drivers,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Drivers
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Driver (Diamond Casino)] 已选择司机：%s ツ", list:GetName(index)))
                    end
                },

                Vehicles = {
                    hash = J("SN_DiamondCasino_Vehicles"),
                    name = "Vehicles",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicles.",
                    list = eTable.Heist.DiamondCasino.Vehicles,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Vehicles
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Vehicles (Diamond Casino)] 已选择载具：%s ツ", list:GetName(index)))
                    end
                },

                Hacker = {
                    hash = J("SN_DiamondCasino_Hacker"),
                    name = "Hacker",
                    type = eFeatureType.Combo,
                    desc = "Select the desired hacker.",
                    list = eTable.Heist.DiamondCasino.Hackers,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Hackers
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Hacker (Diamond Casino)] 已选择黑客：%s ツ", list:GetName(index)))
                    end
                },

                Masks = {
                    hash = J("SN_DiamondCasino_Masks"),
                    name = "Masks",
                    type = eFeatureType.Combo,
                    desc = "Select the desired masks.",
                    list = eTable.Heist.DiamondCasino.Masks,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Masks
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Masks (Diamond Casino)] 已选择面具：%s ツ", list:GetName(index)))
                    end
                },

                Keycards = {
                    hash = J("SN_DiamondCasino_Keycards"),
                    name = "Keycards",
                    type = eFeatureType.Combo,
                    desc = "Select the desired keycards level.",
                    list = eTable.Heist.DiamondCasino.Keycards,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Keycards
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Keycards (Diamond Casino)] 已选择门禁卡等级：%s ツ", list:GetName(index)))
                    end
                },

                Guards = {
                    hash = J("SN_DiamondCasino_Guards"),
                    name = "Guards",
                    type = eFeatureType.Combo,
                    desc = "Select the desired guards strength.",
                    list = eTable.Heist.DiamondCasino.Guards,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Guards
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Guards (Diamond Casino)] 已选择守卫强度：%s ツ", list:GetName(index)))
                    end
                },

                Target = {
                    hash = J("SN_DiamondCasino_Target"),
                    name = "Target",
                    type = eFeatureType.Combo,
                    desc = "Select the desired target.",
                    list = eTable.Heist.DiamondCasino.Targets,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Targets
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Target (Diamond Casino)] 已选择目标：%s ツ", list:GetName(index)))
                    end
                },

                Complete = {
                    hash = J("SN_DiamondCasino_Complete"),
                    name = "Apply & Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Applies all changes and completes all preparations. Also, redraws the planning boards.",
                    func = function(difficulty, approach, gunman, driver, hacker, masks, guards, keycards, target, loadout, vehicles)
                        if CONFIG.unlock_all_poi.diamond_casino then
                            eStat.MPX_H3OPT_POI:Set(-1)
                            eStat.MPX_H3OPT_ACCESSPOINTS:Set(-1)
                            eStat.MPX_CAS_HEIST_NOTS:Set(-1)
                            eStat.MPX_CAS_HEIST_FLOW:Set(-1)
                        end

                        eStat.MPX_H3_LAST_APPROACH:Set(0)
                        eStat.MPX_H3_HARD_APPROACH:Set((difficulty == 0) and 0 or approach)
                        eStat.MPX_H3OPT_APPROACH:Set(approach)
                        eStat.MPX_H3OPT_CREWWEAP:Set(gunman)
                        eStat.MPX_H3OPT_WEAPS:Set(loadout)
                        eStat.MPX_H3OPT_CREWDRIVER:Set(driver)
                        eStat.MPX_H3OPT_VEHS:Set(vehicles)
                        eStat.MPX_H3OPT_CREWHACKER:Set(hacker)
                        eStat.MPX_H3OPT_TARGET:Set(target)
                        eStat.MPX_H3OPT_MASKS:Set(masks)
                        eStat.MPX_H3OPT_DISRUPTSHIP:Set(guards)
                        eStat.MPX_H3OPT_KEYLEVELS:Set(keycards)
                        eStat.MPX_H3OPT_BODYARMORLVL:Set(-1)
                        eStat.MPX_H3OPT_BITSET0:Set(-1)
                        eStat.MPX_H3OPT_BITSET1:Set(-1)
                        eStat.MPX_H3OPT_COMPLETEDPOSIX:Set(-1)

                        eLocal.Heist.DiamondCasino.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply & Complete Preps (Diamond Casino)] 所有准备步骤已完成 ツ")
                    end
                },

                Reset = {
                    hash = J("SN_DiamondCasino_Reset"),
                    name = "Reset Preps",
                    type = eFeatureType.Button,
                    desc = "Resets all preparations. Also, redraws the planning boards.",
                    func = function()
                        eStat.MPX_H3_LAST_APPROACH:Set(0)
                        eStat.MPX_H3_HARD_APPROACH:Set(0)
                        eStat.MPX_H3_APPROACH:Set(0)
                        eStat.MPX_H3OPT_APPROACH:Set(0)
                        eStat.MPX_H3OPT_CREWWEAP:Set(0)
                        eStat.MPX_H3OPT_WEAPS:Set(0)
                        eStat.MPX_H3OPT_CREWDRIVER:Set(0)
                        eStat.MPX_H3OPT_VEHS:Set(0)
                        eStat.MPX_H3OPT_CREWHACKER:Set(0)
                        eStat.MPX_H3OPT_MASKS:Set(0)
                        eStat.MPX_H3OPT_TARGET:Set(0)
                        eStat.MPX_H3OPT_DISRUPTSHIP:Set(0)
                        eStat.MPX_H3OPT_BODYARMORLVL:Set(01)
                        eStat.MPX_H3OPT_KEYLEVELS:Set(0)
                        eStat.MPX_H3OPT_BITSET0:Set(0)
                        eStat.MPX_H3OPT_BITSET1:Set(0)
                        eStat.MPX_H3OPT_POI:Set(0)
                        eStat.MPX_H3OPT_ACCESSPOINTS:Set(0)
                        eStat.MPX_CAS_HEIST_NOTS:Set(0)
                        eStat.MPX_CAS_HEIST_FLOW:Set(0)
                        eStat.MPX_H3_BOARD_DIALOGUE0:Set(0)
                        eStat.MPX_H3_BOARD_DIALOGUE1:Set(0)
                        eStat.MPX_H3_BOARD_DIALOGUE2:Set(0)
                        eStat.MPPLY_H3_COOLDOWN:Set(0)
                        eStat.MPX_H3OPT_COMPLETEDPOSIX:Set(0)
                        eLocal.Heist.DiamondCasino.Reload:Set(2)
                        SilentLogger.LogInfo("[Reset Preps (Diamond Casino)] 所有准备步骤已重置 ツ")
                    end
                },

                Reload = {
                    hash = J("SN_DiamondCasino_Reload"),
                    name = "Redraw Boards",
                    type = eFeatureType.Button,
                    desc = "Redraws the planning boards.",
                    func = function()
                        eLocal.Heist.DiamondCasino.Reload:Set(2)
                        SilentLogger.LogInfo("[Redraw Boards (Diamond Casino)] 规划板已重新绘制 ツ")
                    end
                }
            },

            Launch = {
                Solo = {
                    hash = J("SN_DiamondCasino_Launch"),
                    name = "Solo Launch",
                    type = eFeatureType.Toggle,
                    desc = "Allows launching the current heist alone.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if GTA.IsScriptRunning(eScript.Heist.Launcher) then
                                local value = eLocal.Heist.Generic.Launch.Step1:Get()

                                if value ~= 0 then
                                    if eLocal.Heist.Generic.Launch.Step2:Get() > 1 then
                                        eLocal.Heist.Generic.Launch.Step2:Set(1)
                                    end

                                    if ScriptGlobal.GetInt(794954 + 4 + 1 + (value * 95) + 75) > 1 then
                                        ScriptGlobal.SetInt(794954 + 4 + 1 + (value * 95) + 75, 1)
                                    end

                                    eGlobal.Heist.Generic.Launch.Step1:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step2:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step3:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step4:Set(0)

                                    eLocal.Heist.Generic.Launch.Step3:Set(0)
                                    eGlobal.Heist.Generic.Launch.Step5:Set(1)
                                end
                            end

                            if GTA.IsScriptRunning(eScript.Heist.Old) then
                                if eGlobal.Heist.Generic.IsCasinoFinale:Get() == 1 then
                                    if eStat.MPX_H3OPT_APPROACH:Get() == 2 then
                                        eGlobal.Heist.DiamondCasino.Data.Van:Set(3)
                                    end

                                    eGlobal.Heist.DiamondCasino.Data.Target:Set(eStat.MPX_H3OPT_TARGET:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Cameras:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Patrol:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Guards:Set(eStat.MPX_H3OPT_DISRUPTSHIP:Get())
                                    eGlobal.Heist.DiamondCasino.Data.NVDs:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Drills:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Unknown:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Buyer:Set(math.random(6, 8))
                                    eGlobal.Heist.DiamondCasino.Data.Decoy:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Getaway:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Gunman:Set(eStat.MPX_H3OPT_CREWWEAP:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Weapons:Set(eStat.MPX_H3OPT_WEAPS:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Driver:Set(eStat.MPX_H3OPT_CREWDRIVER:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Vehicles:Set(eStat.MPX_H3OPT_VEHS:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Hacker:Set(eStat.MPX_H3OPT_CREWHACKER:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Keycards:Set(eStat.MPX_H3OPT_KEYLEVELS:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Exit:Set(1)
                                    eGlobal.Heist.DiamondCasino.Data.Masks:Set(eStat.MPX_H3OPT_MASKS:Get())
                                    eGlobal.Heist.DiamondCasino.Data.Infested:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.Bitset:Set(2047)
                                    eGlobal.Heist.DiamondCasino.Data.Gear:Set(true)
                                    eGlobal.Heist.DiamondCasino.Data.HardMode:Set(eStat.MPX_H3OPT_APPROACH:Get() == eStat.MPX_H3_HARD_APPROACH:Get())
                                end
                            end

                            if not loggedDiamondLaunch then
                                SilentLogger.LogInfo("[Solo Launch (Diamond Casino)] 已启用单人发起抢劫任务 ツ")
                                loggedDiamondLaunch = true
                            end
                        else
                            ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, 2)
                            eLocal.Heist.Generic.Launch.Step2:Set(2)
                            eGlobal.Heist.Generic.Launch.Step1:Set(1)
                            eGlobal.Heist.Generic.Launch.Step2:Set(1)
                            eGlobal.Heist.Generic.Launch.Step3:Set(2)
                            eGlobal.Heist.Generic.Launch.Step4:Set(11)

                            SilentLogger.LogInfo("[Solo Launch (Diamond Casino)] 已禁用单人发起抢劫任务 ツ")
                            loggedDiamondLaunch = false
                        end
                    end
                },

                Reset = {
                    hash = J("SN_DiamondCasino_LaunchReset"),
                    name = "Reset",
                    type = eFeatureType.Button,
                    desc = "Resets the launch settings for the current heist.",
                    func = function()
                        ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, 2)
                        eLocal.Heist.Generic.Launch.Step2:Set(2)
                        eGlobal.Heist.Generic.Launch.Step1:Set(1)
                        eGlobal.Heist.Generic.Launch.Step2:Set(1)
                        eGlobal.Heist.Generic.Launch.Step3:Set(2)
                        eGlobal.Heist.Generic.Launch.Step4:Set(11)
                        eLocal.Heist.Generic.Launch.Step3:Set(0)
                        eGlobal.Heist.Generic.Launch.Step5:Set(1)

                        SilentLogger.LogInfo("[Reset (Diamond Casino)] 启动设置已重置 ツ")
                    end
                }
            },

            Misc = {
                Setup = {
                    hash = J("SN_DiamondCasino_Setup"),
                    name = "Skip Setup",
                    type = eFeatureType.Button,
                    desc = "Skips the setup mission for your Arcade. Change the session to apply.",
                    func = function()
                        ePackedStat.Business.Arcade.Setup:Set(true)
                        SilentLogger.LogInfo("[Skip Setup (Diamond Casino)] 街机厅设置任务已跳过。别忘了切换战局生效 ツ")
                    end
                },

                Teleport = {
                    Entrance = {
                        hash = J("SN_DiamondCasino_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Arcade's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Arcade)
                            SilentLogger.LogInfo("[Teleport to Entrance (Diamond Casino)] 你已被传送至街机厅入口 ツ")
                        end
                    },

                    Board = {
                        hash = J("SN_DiamondCasino_Board"),
                        name = "Teleport to Boards",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Arcade's planning boards.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Arcade))
                            SilentLogger.LogInfo("[Teleport to Boards (Diamond Casino)] 你已被传送至街机厅规划板处 ツ")
                        end
                    }
                },

                Force = {
                    hash = J("SN_DiamondCasino_Force"),
                    name = "Force Ready",
                    type = eFeatureType.Button,
                    desc = "Forces everyone to be «Ready».",
                    func = function()
                        GTA.ForceScriptHost(eScript.Heist.Old)
                        Script.Yield(1000)

                        for i = 2, 4 do
                            eGlobal.Heist.DiamondCasino.Ready[F("Player%d", i)]:Set(1)
                        end

                        SilentLogger.LogInfo("[Force Ready (Diamond Casino)] 已强制所有人进入就绪状态 ツ")
                    end
                },

                Finish = {
                    hash = J("SN_DiamondCasino_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        if CONFIG.instant_finish.diamond_casino == 1 then
                            Helper.NewInstantFinishHeist()

                            SilentLogger.LogInfo("[Instant Finish (Diamond Casino)] 抢劫任务已完成。使用的方法：新式 ツ")
                            return
                        end

                        GTA.ForceScriptHost(eScript.Heist.Old)
                        Script.Yield(1000)

                        if eStat.MPX_H3OPT_APPROACH:Get() == 3 then
                            eLocal.Heist.DiamondCasino.Finish.Step1:Set(12)
                            eLocal.Heist.DiamondCasino.Finish.Step3:Set(80)
                            eLocal.Heist.DiamondCasino.Finish.Step4:Set(10000000)
                            eLocal.Heist.DiamondCasino.Finish.Step5:Set(99999)
                            eLocal.Heist.DiamondCasino.Finish.Step6:Set(99999)
                        else
                            eLocal.Heist.DiamondCasino.Finish.Step2:Set(5)
                            eLocal.Heist.DiamondCasino.Finish.Step3:Set(80)
                            eLocal.Heist.DiamondCasino.Finish.Step4:Set(10000000)
                            eLocal.Heist.DiamondCasino.Finish.Step5:Set(99999)
                            eLocal.Heist.DiamondCasino.Finish.Step6:Set(99999)
                        end

                        SilentLogger.LogInfo("[Instant Finish (Diamond Casino)] 抢劫任务已完成。使用的方法：旧式 ツ")
                    end
                },

                FingerprintHack = {
                    hash = J("SN_DiamondCasino_FingerprintHack"),
                    name = "Bypass Fingerprint Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the fingerprint hacking process.",
                    func = function()
                        eLocal.Heist.DiamondCasino.Bypass.FingerprintHack:Set(5)
                        SilentLogger.LogInfo("[Bypass Fingerprint Hack (Diamond Casino)] 指纹破解流程已跳过 ツ")
                    end
                },

                KeypadHack = {
                    hash = J("SN_DiamondCasino_KeypadHack"),
                    name = "Bypass Keypad Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the keypad hacking process.",
                    func = function()
                        eLocal.Heist.DiamondCasino.Bypass.KeypadHack:Set(5)
                        SilentLogger.LogInfo("[Bypass Keypad Hack (Diamond Casino)] 键盘破解流程已跳过 ツ")
                    end
                },

                VaultDoorDrill = {
                    hash = J("SN_DiamondCasino_VaultDoorDrill"),
                    name = "Bypass Vault Door Drill",
                    type = eFeatureType.Button,
                    desc = "Skips the vault door drilling process.",
                    func = function()
                        eLocal.Heist.DiamondCasino.Bypass.VaultDrill1:Set(eLocal.Heist.DiamondCasino.Bypass.VaultDrill2:Get())
                        SilentLogger.LogInfo("[Bypass Vault Door Drill (Diamond Casino)] 金库门钻孔流程已跳过 ツ")
                    end
                },

                Autograbber = {
                    hash = J("SN_DiamondCasino_Autograbber"),
                    name = "Autograbber",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: might be slower than manually.\nGrabs cash/gold/diamonds automatically.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if eLocal.Heist.DiamondCasino.Autograbber.Grab:Get() == 3 then
                                eLocal.Heist.DiamondCasino.Autograbber.Grab:Set(4)
                            elseif eLocal.Heist.DiamondCasino.Autograbber.Grab:Get() == 4 then
                                eLocal.Heist.DiamondCasino.Autograbber.Speed:Set(2.0)
                            end

                            if not loggedDiamondAuto then
                                SilentLogger.LogInfo("[Autograbber (Diamond Casino)] 自动拾取功能已启用 ツ")
                                loggedDiamondAuto = true
                            end
                        else
                            SilentLogger.LogInfo("[Autograbber (Diamond Casino)] 自动拾取功能已禁用 ツ")
                            loggedDiamondAuto = false
                        end
                    end
                },

                Cooldown = {
                    hash = J("SN_DiamondCasino_Cooldown"),
                    name = "Kill Cooldown",
                    type = eFeatureType.Button,
                    desc = "Skips the heist's cooldown. Doesn't skip the cooldown between transactions (20 min). Use outside of your arcade.",
                    func = function()
                        eStat.MPX_H3_COMPLETEDPOSIX:Set(-1)
                        eStat.MPPLY_H3_COOLDOWN:Set(-1)
                        SilentLogger.LogInfo("[Kill Cooldown (Diamond Casino)] 冷却时间已清除 ツ")
                    end
                }
            },

            Cuts = {
                Crew = {
                    hash = J("SN_DiamondCasino_Crew"),
                    name = "Remove Crew Cuts",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: cannot be unused with «3.6mil Payout».\nRemoves crew cuts and Lester's cut.",
                    func = function(ftr)
                        local function SetOrResetCuts(tbl, bool)
                            for _, v in pairs(tbl) do
                                if type(v) == "table" and v.Set then
                                    if bool then
                                        v:Set(0)
                                    else
                                        v:Reset()
                                    end
                                elseif type(v) == "table" then
                                    SetOrResetCuts(v, bool)
                                end
                            end
                        end

                        SetOrResetCuts(eTunable.Heist.DiamondCasino.Cut, ftr:IsToggled())

                        if ftr:IsToggled() then
                            if not loggedDiamondCrew then
                                SilentLogger.LogInfo("[Remove Crew Cuts (Diamond Casino)] 团队抽成已移除 ツ")
                                loggedDiamondCrew = true
                            end
                        else
                            SilentLogger.LogInfo("[Remove Crew Cuts (Diamond Casino)] 团队抽成已重置 ツ")
                            loggedDiamondCrew = false
                        end
                    end
                },

                Presets = {
                    hash = J("SN_DiamondCasino_Presets"),
                    name = "Presets",
                    type = eFeatureType.Combo,
                    desc = "ATTENTION: if not solo, «3.6mil Payout» works only if you've set the «Buyer» as «Low Level».\nSelect one of the ready-made presets.",
                    list = eTable.Heist.DiamondCasino.Presets,
                    func = function()
                        Helper.SetDiamondMaxPayout()
                        Script.Yield()
                    end
                },

                Player1 = {
                    Toggle = {
                        hash = J("SN_DiamondCasino_Player1_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 1.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 1 (Diamond Casino)] 1号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_DiamondCasino_Player1_Cut"),
                        name = "Player 1",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 1.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 1 (Diamond Casino)] 1号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player2 = {
                    Toggle = {
                        hash = J("SN_DiamondCasino_Player2_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 2.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 2 (Diamond Casino)] 2号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_DiamondCasino_Player2_Cut"),
                        name = "Player 2",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 2.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 2 (Diamond Casino)] 2号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player3 = {
                    Toggle = {
                        hash = J("SN_DiamondCasino_Player3_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 3.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 3 (Diamond Casino)] 3号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_DiamondCasino_Player3_Cut"),
                        name = "Player 3",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 3.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 3 (Diamond Casino)] 3号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player4 = {
                    Toggle = {
                        hash = J("SN_DiamondCasino_Player4_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 4.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 4 (Diamond Casino)] 4号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_DiamondCasino_Player4_Cut"),
                        name = "Player 4",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 4.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 4 (Diamond Casino)] 4号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Apply = {
                    hash = J("SN_DiamondCasino_Apply"),
                    name = "Apply Cuts",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: if solo, apply near the planning board.\nApplies the selected cuts for players.",
                    func = function(cuts)
                        for i = 1, 4 do
                            eGlobal.Heist.DiamondCasino.Cut[F("Player%d", i)]:Set(cuts[i])
                        end
                        SilentLogger.LogInfo("[Apply Cuts (Diamond Casino)] 分红已生效 ツ")
                    end
                }
            },

            Presets = {
                File = {
                    hash = J("SN_DiamondCasino_File"),
                    name = "File",
                    type = eFeatureType.Combo,
                    desc = "Select the desired preset.",
                    list = eTable.Heist.DiamondCasino.Files,
                    func = function(ftr)
                        local list  = eTable.Heist.DiamondCasino.Files
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[File (Diamond Casino)] 已选择抢劫任务预设：%s ツ", (list:GetName(index) == "") and "空预设" or list:GetName(index)))
                    end
                },

                Load = {
                    hash = J("SN_DiamondCasino_Load"),
                    name = "Load",
                    type = eFeatureType.Button,
                    desc = "Loads the selected preset, but doesn't complete preparations.",
                    func = function(file)
                        local path = F("%s\\%s.json", DIAMOND_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            local preps = Json.DecodeFromFile(path)
                            Helper.ApplyDiamondPreset(preps)
                            SilentLogger.LogInfo(F("[Load (Diamond Casino)] 预设«%s»已加载 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Load (Diamond Casino)] 预设«%s»不存在 ツ", (file == "") and "空预设" or file))
                    end
                },

                Remove = {
                    hash = J("SN_DiamondCasino_Remove"),
                    name = "Remove",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: cannot be undone.\nRemoves the selected preset.",
                    func = function(file)
                        local path = F("%s\\%s.json", DIAMOND_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            FileMgr.DeleteFile(path)
                            Helper.RefreshFiles()
                            SilentLogger.LogInfo(F("[Remove (Diamond Casino)] 预设«%s»已删除 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Remove (Diamond Casino)] 预设«%s»不存在 ツ", (file == "") and "空预设" or file))
                    end
                },

                Refresh = {
                    hash = J("SN_DiamondCasino_Refresh"),
                    name = "Refresh",
                    type = eFeatureType.Button,
                    desc = "Refreshes the list of presets.",
                    func = function()
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo("[Refresh (Diamond Casino)] 抢劫任务预设列表已刷新 ツ")
                    end
                },

                Name = {
                    hash = J("SN_DiamondCasino_Name"),
                    name = "QuickPreset",
                    type = eFeatureType.InputText,
                    desc = "Input the desired preset name."
                },

                Save = {
                    hash = J("SN_DiamondCasino_Save"),
                    name = "Save",
                    type = eFeatureType.Button,
                    desc = "Saves the current heist preset to the file.",
                    func = function(file, preps)
                        local path = F("%s\\%s.json", DIAMOND_DIR, file)
                        FileMgr.CreateHeistPresetsDirs()
                        Json.EncodeToFile(path, preps)
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo(F("[Save (Diamond Casino)] 预设«%s»已保存 ツ", file))
                    end
                },

                Copy = {
                    hash = J("SN_DiamondCasino_Copy"),
                    name = "Copy Folder Path",
                    type = eFeatureType.Button,
                    desc = "Copies the presets folder path to the clipboard.",
                    func = function()
                        FileMgr.CreateHeistPresetsDirs()
                        ImGui.SetClipboardText(DIAMOND_DIR)
                        SilentLogger.LogInfo("[Copy Folder Path (Diamond Casino)] 预设文件夹路径已复制到剪贴板 ツ")
                    end
                }
            }
        },

        Doomsday = {
            Preps = {
                Act = {
                    hash = J("SN_Doomsday_Act"),
                    name = "Act",
                    type = eFeatureType.Combo,
                    desc = "Select the desired doomsday act.",
                    list = eTable.Heist.Doomsday.Acts,
                    func = function(ftr)
                        local list  = eTable.Heist.Doomsday.Acts
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Act (Doomsday)] 已选择行动章节：%s ツ", list:GetName(index)))
                    end
                },

                Complete = {
                    hash = J("SN_Doomsday_Complete"),
                    name = "Apply & Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Applies all changes and completes all preparations. Also, reloads the planning screen.",
                    func = function(act)
                        local acts = {
                            [1] = { 503,   -229383 },
                            [2] = { 240,   -229378 },
                            [3] = { 16368, -229380 }
                        }

                        eStat.MPX_GANGOPS_FLOW_MISSION_PROG:Set(acts[act][1])
                        eStat.MPX_GANGOPS_HEIST_STATUS:Set(acts[act][2])
                        eStat.MPX_GANGOPS_FLOW_NOTIFICATIONS:Set(1557)
                        eLocal.Heist.Doomsday.Reload:Set(6)
                        SilentLogger.LogInfo(F("[Apply & Complete Preps (Doomsday)] 所有准备步骤已完成 ツ", act))
                    end
                },

                Reset = {
                    hash = J("SN_Doomsday_Reset"),
                    name = "Reset Preps",
                    type = eFeatureType.Button,
                    desc = "Resets all preparations. Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_GANGOPS_FLOW_MISSION_PROG:Set(503)
                        eStat.MPX_GANGOPS_HEIST_STATUS:Set(0)
                        eStat.MPX_GANGOPS_FLOW_NOTIFICATIONS:Set(1557)
                        eLocal.Heist.Doomsday.Reload:Set(6)
                        SilentLogger.LogInfo("[Reset Preps (Doomsday)] 所有准备步骤已重置 ツ")
                    end
                },

                Reload = {
                    hash = J("SN_Doomsday_Reload"),
                    name = "Reload Screen",
                    type = eFeatureType.Button,
                    desc = "Reloads the planning screen.",
                    func = function()
                        eLocal.Heist.Doomsday.Reload:Set(6)
                        SilentLogger.LogInfo("[Reload Screen (Doomsday)] 规划界面已重新加载 ツ")
                    end
                }
            },

            Launch = {
                Solo = {
                    hash = J("SN_Doomsday_Launch"),
                    name = "Solo Launch",
                    type = eFeatureType.Toggle,
                    desc = "Allows launching the current heist alone.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if GTA.IsScriptRunning(eScript.Heist.Launcher) then
                                local value = eLocal.Heist.Generic.Launch.Step1:Get()

                                if value ~= 0 then
                                    if eLocal.Heist.Generic.Launch.Step2:Get() > 1 then
                                        eLocal.Heist.Generic.Launch.Step2:Set(1)
                                    end

                                    if ScriptGlobal.GetInt(794954 + 4 + 1 + (value * 95) + 75) > 1 then
                                        ScriptGlobal.SetInt(794954 + 4 + 1 + (value * 95) + 75, 1)
                                    end

                                    eGlobal.Heist.Generic.Launch.Step1:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step2:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step3:Set(1)
                                    eGlobal.Heist.Generic.Launch.Step4:Set(0)

                                    eLocal.Heist.Generic.Launch.Step3:Set(0)
                                    eGlobal.Heist.Generic.Launch.Step5:Set(1)
                                end
                            end

                            if not loggedDoomsdayLaunch then
                                SilentLogger.LogInfo("[Solo Launch (Doomsday)] 已启用单人发起抢劫任务 ツ")
                                loggedDoomsdayLaunch = true
                            end
                        else
                            ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, 2)
                            eLocal.Heist.Generic.Launch.Step2:Set(2)
                            eGlobal.Heist.Generic.Launch.Step1:Set(1)
                            eGlobal.Heist.Generic.Launch.Step2:Set(1)
                            eGlobal.Heist.Generic.Launch.Step3:Set(2)
                            eGlobal.Heist.Generic.Launch.Step4:Set(11)

                            SilentLogger.LogInfo("[Solo Launch (Doomsday)] 已禁用单人发起抢劫任务 ツ")
                            loggedDoomsdayLaunch = false
                        end
                    end
                },

                Reset = {
                    hash = J("SN_Doomsday_LaunchReset"),
                    name = "Reset",
                    type = eFeatureType.Button,
                    desc = "Resets the launch settings for the current heist.",
                    func = function()
                        ScriptGlobal.SetInt(794954 + 4 + 1 + (eLocal.Heist.Generic.Launch.Step1:Get() * 95) + 75, 2)
                        eLocal.Heist.Generic.Launch.Step2:Set(2)
                        eGlobal.Heist.Generic.Launch.Step1:Set(1)
                        eGlobal.Heist.Generic.Launch.Step2:Set(1)
                        eGlobal.Heist.Generic.Launch.Step3:Set(2)
                        eGlobal.Heist.Generic.Launch.Step4:Set(11)
                        eLocal.Heist.Generic.Launch.Step3:Set(0)
                        eGlobal.Heist.Generic.Launch.Step5:Set(1)

                        SilentLogger.LogInfo("[Reset (Doomsday)] 启动设置已重置 ツ")
                    end
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_Doomsday_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Facility's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Facility)
                            SilentLogger.LogInfo("[Teleport to Entrance (Doomsday)] 你已被传送至设施入口 ツ")
                        end
                    },

                    Screen = {
                        hash = J("SN_Doomsday_Screen"),
                        name = "Teleport to Screen",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Facility's planning screen.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Heist, 325.726, true)
                            SilentLogger.LogInfo("[Teleport to Screen (Doomsday)] 你已被传送至设施规划界面处 ツ")
                        end
                    }
                },

                Force = {
                    hash = J("SN_Doomsday_Force"),
                    name = "Force Ready",
                    type = eFeatureType.Button,
                    desc = "Forces everyone to be «Ready».",
                    func = function()
                        GTA.ForceScriptHost(eScript.Heist.Old)
                        Script.Yield(1000)

                        for i = 2, 4 do
                            eGlobal.Heist.Doomsday.Ready[F("Player%d", i)]:Set(1)
                        end

                        SilentLogger.LogInfo("[Force Ready (Doomsday)] 已强制所有人进入就绪状态 ツ")
                    end
                },

                Finish = {
                    hash = Utils.Joaat("SN_Doomsday_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        if CONFIG.instant_finish.doomsday == 1 then
                            Helper.NewInstantFinishHeist()

                            SilentLogger.LogInfo("[Instant Finish (Doomsday)] 抢劫任务已完成。使用的方法：新式 ツ")
                            return
                        end

                        GTA.ForceScriptHost(eScript.Heist.Old)
                        Script.Yield(1000)
                        eLocal.Heist.Doomsday.Finish.Step1:Set(12)
                        eLocal.Heist.Doomsday.Finish.Step2:Set(150)
                        eLocal.Heist.Doomsday.Finish.Step3:Set(99999)
                        eLocal.Heist.Doomsday.Finish.Step4:Set(99999)
                        eLocal.Heist.Doomsday.Finish.Step5:Set(80)
                        SilentLogger.LogInfo("[Instant Finish (Doomsday)] 抢劫任务已完成。使用的方法：旧式 ツ")
                    end
                },

                DataHack = {
                    hash = J("SN_Doomsday_DataHack"),
                    name = "Bypass Data Breaches Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the hacking process of The Data Breaches heist.",
                    func = function()
                        eLocal.Heist.Doomsday.Bypass.DataHack:Set(2)
                        SilentLogger.LogInfo("[Bypass Data Breaches Hack (Doomsday)] 数据泄露抢劫破解流程已跳过 ツ")
                    end
                },

                DoomsdayHack = {
                    hash = J("SN_Doomsday_DoomsdayHack"),
                    name = "Bypass Dooms. Scen. Hack",
                    type = eFeatureType.Button,
                    desc = "Skips the hacking process of The Doomsday Scenario heist.",
                    func = function()
                        eLocal.Heist.Doomsday.Bypass.DoomsdayHack:Set(3)
                        SilentLogger.LogInfo("[Bypass Doomsday Scenario Hack (Doomsday)] 末日场景抢劫破解流程已跳过 ツ")
                    end
                }
            },

            Cuts = {
                Presets = {
                    hash = J("SN_Doomsday_Presets"),
                    name = "Presets",
                    type = eFeatureType.Combo,
                    desc = "ATTENTION: «2.55mil Payout» works only if you've set the «Act» through the script.\nSelect one of the ready-made presets.",
                    list = eTable.Heist.Doomsday.Presets,
                    func = function()
                        Helper.SetDoomsdayMaxPayout()
                        Script.Yield()
                    end
                },

                Player1 = {
                    Toggle = {
                        hash = J("SN_Doomsday_Player1_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 1.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 1 (Doomsday)] 1号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Doomsday_Player1"),
                        name = "Player 1",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 1.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 1 (Doomsday)] 1号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player2 = {
                    Toggle = {
                        hash = J("SN_Doomsday_Player2_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 2.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 2 (Doomsday)] 2号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Doomsday_Player2"),
                        name = "Player 2",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 2.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 2 (Doomsday)] 2号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player3 = {
                    Toggle = {
                        hash = J("SN_Doomsday_Player3_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 3.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 3 (Doomsday)] 3号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Doomsday_Player3"),
                        name = "Player 3",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 3.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 3 (Doomsday)] 3号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Player4 = {
                    Toggle = {
                        hash = J("SN_Doomsday_Player4_Toggle"),
                        name = "",
                        type = eFeatureType.Toggle,
                        desc = "Enable the cut for Player 4.",
                        func = function(ftr)
                            SilentLogger.LogInfo(F("[Player 4 (Doomsday)] 4号玩家分红已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                        end
                    },

                    Cut = {
                        hash = J("SN_Doomsday_Player4"),
                        name = "Player 4",
                        type = eFeatureType.InputInt,
                        desc = "Select the cut for Player 4.",
                        defv = 0,
                        lims = { 0, 999 },
                        step = 1,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Player 4 (Doomsday)] 4号玩家分红已更改。别忘了应用更改 ツ")
                        end
                    }
                },

                Apply = {
                    hash = J("SN_Doomsday_Apply"),
                    name = "Apply Cuts",
                    type = eFeatureType.Button,
                    desc = "Applies the selected cuts for players.",
                    func = function(cuts)
                        for i = 1, 4 do
                            eGlobal.Heist.Doomsday.Cut[F("Player%d", i)]:Set(cuts[i])
                        end
                        SilentLogger.LogInfo("[Apply Cuts (Doomsday)] 分红已生效 ツ")
                    end
                }
            },

            Presets = {
                File = {
                    hash = J("SN_Doomsday_File"),
                    name = "File",
                    type = eFeatureType.Combo,
                    desc = "Select the desired preset.",
                    list = eTable.Heist.Doomsday.Files,
                    func = function(ftr)
                        local list  = eTable.Heist.Doomsday.Files
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[File (Doomsday)] 已选择抢劫任务预设：%s ツ", (list:GetName(index) == "") and "空预设" or list:GetName(index)))
                    end
                },

                Load = {
                    hash = J("SN_Doomsday_Load"),
                    name = "Load",
                    type = eFeatureType.Button,
                    desc = "Loads the selected preset, but doesn't complete preparations.",
                    func = function(file)
                        local path = F("%s\\%s.json", DDAY_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            local preps = Json.DecodeFromFile(path)
                            Helper.ApplyDoomsdayPreset(preps)
                            SilentLogger.LogInfo(F("[Load (Doomsday)] 预设«%s»已加载 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Load (Doomsday)] 预设«%s»不存在 ツ", (file == "") and "空预设" or file))
                    end
                },

                                Remove = {
                    hash = J("SN_Doomsday_Remove"),
                    name = "Remove",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: cannot be undone.\nRemoves the selected preset.",
                    func = function(file)
                        local path = F("%s\\%s.json", DDAY_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            FileMgr.DeleteFile(path)
                            Helper.RefreshFiles()
                            SilentLogger.LogInfo(F("[Remove (Doomsday)] 预设«%s»已删除 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Remove (Doomsday)] 预设«%s»不存在 ツ", (file == "") and "空预设" or file))
                    end
                },

                Refresh = {
                    hash = J("SN_Doomsday_Refresh"),
                    name = "Refresh",
                    type = eFeatureType.Button,
                    desc = "Refreshes the list of presets.",
                    func = function()
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo("[Refresh (Doomsday)] 抢劫任务预设列表已刷新 ツ")
                    end
                },

                Name = {
                    hash = J("SN_Doomsday_Name"),
                    name = "QuickPreset",
                    type = eFeatureType.InputText,
                    desc = "Input the desired preset name."
                },

                Save = {
                    hash = J("SN_Doomsday_Save"),
                    name = "Save",
                    type = eFeatureType.Button,
                    desc = "Saves the current heist preset to the file.",
                    func = function(file, preps)
                        local path = F("%s\\%s.json", DDAY_DIR, file)
                        FileMgr.CreateHeistPresetsDirs()
                        Json.EncodeToFile(path, preps)
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo(F("[Save (Doomsday)] 预设«%s»已保存 ツ", file))
                    end
                },

                Copy = {
                    hash = J("SN_Doomsday_Copy"),
                    name = "Copy Folder Path",
                    type = eFeatureType.Button,
                    desc = "Copies the presets folder path to the clipboard.",
                    func = function()
                        FileMgr.CreateHeistPresetsDirs()
                        ImGui.SetClipboardText(DDAY_DIR)
                        SilentLogger.LogInfo("[Copy Folder Path (Doomsday)] 预设文件夹路径已复制到剪贴板 ツ")
                    end
                }
            }
        },

        SalvageYard = {
            Slot1 = {
                Available = {
                    hash = J("SN_SalvageYard_AvailableSlot1"),
                    name = "Make Available",
                    type = eFeatureType.Button,
                    desc = "Makes the slot 1 «Available». Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_SALV23_VEHROB_STATUS0:Set(0)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Make Available (Salvage Yard)] 1号插槽已设为«可用»状态 ツ")
                    end
                },

                Robbery = {
                    hash = J("SN_SalvageYard_RobberySlot1"),
                    name = "Robbery",
                    type = eFeatureType.Combo,
                    desc = "Select the desired robbery type for slot 1.",
                    list = eTable.Heist.SalvageYard.Robberies,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Robberies
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Robbery (Salvage Yard)] 已选择1号插槽抢劫类型：%s ツ", list:GetName(index)))
                    end
                },

                Vehicle = {
                    hash = J("SN_SalvageYard_VehicleSlot1"),
                    name = "Vehicle",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicle type for slot 1.",
                    list = eTable.Heist.SalvageYard.Vehicles,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Vehicles
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Vehicle (Salvage Yard)] 已选择1号插槽载具类型：%s ツ", list:GetName(index)))
                    end
                },

                Modification = {
                    hash = J("SN_SalvageYard_ModificationSlot1"),
                    name = "Modification",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicle modification for slot 1.",
                    list = eTable.Heist.SalvageYard.Modifications,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Modifications
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Modification (Salvage Yard)] 已选择1号插槽载具改装：%s ツ", list:GetName(index)))
                    end
                },

                Keep = {
                    hash = J("SN_SalvageYard_KeepSlot1"),
                    name = "Status",
                    type = eFeatureType.Combo,
                    desc = "Select whether you can keep the vehicle for slot 1.",
                    list = eTable.Heist.SalvageYard.Keeps,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Keeps
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Status (Salvage Yard)] 已选择1号插槽载具保留状态：%s ツ", list:GetName(index)))
                    end
                },

                Apply = {
                    hash = J("SN_SalvageYard_ApplySlot1"),
                    name = "Apply Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes for the slot 1. Also, reloads the planning screen. Use before you start the preparation.",
                    func = function(robbery, vehicle, modification, keep)
                        eTunable.Heist.SalvageYard.Robbery.Slot1.Type:Set(robbery)
                        eTunable.Heist.SalvageYard.Vehicle.Slot1.Type:Set(vehicle + modification * 100)
                        eTunable.Heist.SalvageYard.Vehicle.Slot1.CanKeep:Set(keep)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply Changes (Salvage Yard)] 1号插槽更改已生效 ツ")
                    end
                }
            },

            Slot2 = {
                Available = {
                    hash = J("SN_SalvageYard_AvailableSlot2"),
                    name = "Make Available",
                    type = eFeatureType.Button,
                    desc = "Makes the slot 2 «Available». Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_SALV23_VEHROB_STATUS1:Set(0)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Make Available (Salvage Yard)] 2号插槽已设为«可用»状态 ツ")
                    end
                },

                Robbery = {
                    hash = J("SN_SalvageYard_RobberySlot2"),
                    name = "Robbery",
                    type = eFeatureType.Combo,
                    desc = "Select the desired robbery type for slot 2.",
                    list = eTable.Heist.SalvageYard.Robberies,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Robberies
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Robbery (Salvage Yard)] 已选择2号插槽抢劫类型：%s ツ", list:GetName(index)))
                    end
                },

                Vehicle = {
                    hash = J("SN_SalvageYard_VehicleSlot2"),
                    name = "Vehicle",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicle type for slot 2.",
                    list = eTable.Heist.SalvageYard.Vehicles,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Vehicles
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Vehicle (Salvage Yard)] 已选择2号插槽载具类型：%s ツ", list:GetName(index)))
                    end
                },

                Modification = {
                    hash = J("SN_SalvageYard_ModificationSlot2"),
                    name = "Modification",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicle modification for slot 2.",
                    list = eTable.Heist.SalvageYard.Modifications,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Modifications
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Modification (Salvage Yard)] 已选择2号插槽载具改装：%s ツ", list:GetName(index)))
                    end
                },

                Keep = {
                    hash = J("SN_SalvageYard_KeepSlot2"),
                    name = "Status",
                    type = eFeatureType.Combo,
                    desc = "Select whether you can keep the vehicle for slot 2.",
                    list = eTable.Heist.SalvageYard.Keeps,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Keeps
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Status (Salvage Yard)] 已选择2号插槽载具保留状态：%s ツ", list:GetName(index)))
                    end
                },

                Apply = {
                    hash = J("SN_SalvageYard_ApplySlot2"),
                    name = "Apply Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes for the slot 2. Also, reloads the planning screen. Use before you start the preparation.",
                    func = function(robbery, vehicle, modification, keep)
                        eTunable.Heist.SalvageYard.Robbery.Slot2.Type:Set(robbery)
                        eTunable.Heist.SalvageYard.Vehicle.Slot2.Type:Set(vehicle + modification * 100)
                        eTunable.Heist.SalvageYard.Vehicle.Slot2.CanKeep:Set(keep)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply Changes (Salvage Yard)] 2号插槽更改已生效 ツ")
                    end
                }
            },

            Slot3 = {
                Available = {
                    hash = J("SN_SalvageYard_AvailableSlot3"),
                    name = "Make Available",
                    type = eFeatureType.Button,
                    desc = "Makes the slot 3 «Available». Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_SALV23_VEHROB_STATUS2:Set(0)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Make Available (Salvage Yard)] 3号插槽已设为«可用»状态 ツ")
                    end
                },

                Robbery = {
                    hash = J("SN_SalvageYard_RobberySlot3"),
                    name = "Robbery",
                    type = eFeatureType.Combo,
                    desc = "Select the desired robbery type for slot 3.",
                    list = eTable.Heist.SalvageYard.Robberies,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Robberies
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Robbery (Salvage Yard)] 已选择3号插槽抢劫类型：%s ツ", list:GetName(index)))
                    end
                },

                Vehicle = {
                    hash = J("SN_SalvageYard_VehicleSlot3"),
                    name = "Vehicle",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicle type for slot 3.",
                    list = eTable.Heist.SalvageYard.Vehicles,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Vehicles
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Vehicle (Salvage Yard)] 已选择3号插槽载具类型：%s ツ", list:GetName(index)))
                    end
                },

                Modification = {
                    hash = J("SN_SalvageYard_ModificationSlot3"),
                    name = "Modification",
                    type = eFeatureType.Combo,
                    desc = "Select the desired vehicle modification for slot 3.",
                    list = eTable.Heist.SalvageYard.Modifications,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Modifications
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Modification (Salvage Yard)] 已选择3号插槽载具改装：%s ツ", list:GetName(index)))
                    end
                },

                Keep = {
                    hash = J("SN_SalvageYard_KeepSlot3"),
                    name = "Status",
                    type = eFeatureType.Combo,
                    desc = "Select whether you can keep the vehicle for slot 3.",
                    list = eTable.Heist.SalvageYard.Keeps,
                    func = function(ftr)
                        local list  = eTable.Heist.SalvageYard.Keeps
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Status (Salvage Yard)] 已选择3号插槽载具保留状态：%s ツ", list:GetName(index)))
                    end
                },

                Apply = {
                    hash = J("SN_SalvageYard_ApplySlot3"),
                    name = "Apply Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes for the slot 3. Also, reloads the planning screen. Use before you start the preparation.",
                    func = function(robbery, vehicle, modification, keep)
                        eTunable.Heist.SalvageYard.Robbery.Slot3.Type:Set(robbery)
                        eTunable.Heist.SalvageYard.Vehicle.Slot3.Type:Set(vehicle + modification * 100)
                        eTunable.Heist.SalvageYard.Vehicle.Slot3.CanKeep:Set(keep)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply Changes (Salvage Yard)] 3号插槽更改已生效 ツ")
                    end
                }
            },

            Preps = {
                Apply = {
                    hash = J("SN_SalvageYard_ApplyAll"),
                    name = "Apply All Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes. Also, reloads the planning screen. Use before you start the preparation.",
                    func = function(robbery1, vehicle1, mod1, keep1, robbery2, vehicle2, mod2, keep2, robbery3, vehicle3, mod3, keep3)
                        eTunable.Heist.SalvageYard.Robbery.Slot1.Type:Set(robbery1)
                        eTunable.Heist.SalvageYard.Vehicle.Slot1.Type:Set(vehicle1 + mod1 * 100)
                        eTunable.Heist.SalvageYard.Vehicle.Slot1.CanKeep:Set(keep1)
                        eTunable.Heist.SalvageYard.Robbery.Slot2.Type:Set(robbery2)
                        eTunable.Heist.SalvageYard.Vehicle.Slot2.Type:Set(vehicle2 + mod2 * 100)
                        eTunable.Heist.SalvageYard.Vehicle.Slot2.CanKeep:Set(keep2)
                        eTunable.Heist.SalvageYard.Robbery.Slot3.Type:Set(robbery3)
                        eTunable.Heist.SalvageYard.Vehicle.Slot3.Type:Set(vehicle3 + mod3 * 100)
                        eTunable.Heist.SalvageYard.Vehicle.Slot3.CanKeep:Set(keep3)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply All Changes (Salvage Yard)] 所有更改已生效 ツ")
                    end
                },

                Complete = {
                    hash = J("SN_SalvageYard_Complete"),
                    name = "Complete Preps",
                    type = eFeatureType.Button,
                    desc = "Completes all preparations. Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_SALV23_GEN_BS:Set(-1)
                        eStat.MPX_SALV23_SCOPE_BS:Set(-1)
                        eStat.MPX_SALV23_FM_PROG:Set(-1)
                        eStat.MPX_SALV23_INST_PROG:Set(-1)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Complete Preps (Salvage Yard)] 所有准备步骤已完成 ツ")
                    end
                },

                Reset = {
                    hash = J("SN_SalvageYard_Reset"),
                    name = "Reset Preps",
                    type = eFeatureType.Button,
                    desc = "Resets all preparations. Also, reloads the planning screen.",
                    func = function()
                        eStat.MPX_SALV23_GEN_BS:Set(0)
                        eStat.MPX_SALV23_SCOPE_BS:Set(0)
                        eStat.MPX_SALV23_FM_PROG:Set(0)
                        eStat.MPX_SALV23_INST_PROG:Set(0)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Reset Preps (Salvage Yard)] 所有准备步骤已重置 ツ")
                    end
                },

                Reload = {
                    hash = J("SN_SalvageYard_Reload"),
                    name = "Reload Screen",
                    type = eFeatureType.Button,
                    desc = "Reloads the planning screen.",
                    func = function()
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Reload Screen (Salvage Yard)] 规划界面已重新加载 ツ")
                    end
                },

                Free = {
                    Setup = {
                        hash = J("SN_SalvageYard_Setup"),
                        name = "Free Setup",
                        type = eFeatureType.Toggle,
                        desc = "Allows setuping the heist for free.",
                        func = function(ftr)
                            eTunable.Heist.SalvageYard.Robbery.SetupPrice:Set((ftr:IsToggled()) and 0 or 20000)

                            if ftr:IsToggled() then
                                if not loggedSalvageSetup then
                                    SilentLogger.LogInfo("[Free Setup (Salvage Yard)] 筹备费用已设为免费 ツ")
                                    loggedSalvageSetup = true
                                end
                            else
                                SilentLogger.LogInfo("[Free Setup (Salvage Yard)] 筹备费用已恢复收费 ツ")
                                loggedSalvageSetup = false
                            end
                        end
                    },

                    Claim = {
                        hash = J("SN_SalvageYard_Claim"),
                        name = "Free Claim",
                        type = eFeatureType.Toggle,
                        desc = "Allows claiming the vehicles for free.",
                        func = function(ftr)
                            eTunable.Heist.SalvageYard.Vehicle.ClaimPrice.Standard:Set((ftr:IsToggled()) and 0 or 20000)
                            eTunable.Heist.SalvageYard.Vehicle.ClaimPrice.Discounted:Set((ftr:IsToggled()) and 0 or 10000)

                            if ftr:IsToggled() then
                                if not loggedSalvageClaim then
                                    SilentLogger.LogInfo("[Free Claim (Salvage Yard)] 载具认领费用已设为免费 ツ")
                                    loggedSalvageClaim = true
                                end
                            else
                                SilentLogger.LogInfo("[Free Claim (Salvage Yard)] 载具认领费用已恢复收费 ツ")
                                loggedSalvageClaim = false
                            end
                        end
                    }
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_SalvageYard_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Salvage Yard's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.SalvageYard)
                            SilentLogger.LogInfo("[Teleport to Entrance (Salvage Yard)] 你已被传送至废车场入口 ツ")
                        end
                    },

                    Board = {
                        hash = J("SN_SalvageYard_Board"),
                        name = "Teleport to Screen & Board",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Salvage Yard's planning screen and board.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.SalvageYard))
                            SilentLogger.LogInfo("[Teleport to Screen & Board (Salvage Yard)] 你已被传送至废车场规划界面和规划板处 ツ")
                        end
                    }
                },

                Finish = {
                    hash = J("SN_SalvageYard_Finish"),
                    name = "Instant Finish",
                    type = eFeatureType.Button,
                    desc = "Finishes the heist instantly. Use after you can see the minimap.",
                    func = function()
                        for heist, script in pairs(eScript.SalvageYard.Heist) do
                            if GTA.IsScriptRunning(script) then
                                local value = Bits.SetBit(eLocal.Heist.SalvageYard.Finish[heist].Step1:Get(), 11)
                                eLocal.Heist.SalvageYard.Finish[heist].Step1:Set(value)
                                eLocal.Heist.SalvageYard.Finish[heist].Step2:Set(2)
                                break
                            end
                        end
                        SilentLogger.LogInfo("[Instant Finish (Salvage Yard)] 抢劫任务已完成 ツ")
                    end
                },

                Sell = {
                    hash = J("SN_SalvageYard_Sell"),
                    name = "Instant Sell",
                    type = eFeatureType.Button,
                    desc = "Finishes the sell mission instantly. Use after you can see the minimap.",
                    func = function()
                        GTA.TeleportXYZ(U(eTable.Teleports.Terminal))
                        SilentLogger.LogInfo("[Instant Sell (Salvage Yard)] 出售任务已完成 ツ")
                    end
                },

                Force = {
                    hash = J("SN_SalvageYard_Force"),
                    name = "Force Through Error",
                    type = eFeatureType.Button,
                    desc = "Forces the heist to become active through the error.",
                    func = function()
                        eLocal.Heist.SalvageYard.Force:Set(1)
                        SilentLogger.LogInfo("[Force Through Error (Salvage Yard)] 已强制跳过错误提示 ツ")
                    end
                },

                Cooldown = {
                    hash = J("SN_SalvageYard_Cooldown"),
                    name = "Skip Weekly Cooldown",
                    type = eFeatureType.Button,
                    desc = "Skips the heist's weekly cooldown. Also, reloads the planning screen.",
                    func = function()
                        eTunable.Heist.SalvageYard.Cooldown.Weekly:Set(eStat.MPX_SALV23_WEEK_SYNC:Get() + 1)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Skip Weekly Cooldown (Salvage Yard)] 冷却时间已跳过 ツ")
                    end
                }
            },

            Payout = {
                Salvage = {
                    hash = J("SN_SalvageYard_Salvage"),
                    name = "Salvage Value Multiplier",
                    type = eFeatureType.InputFloat,
                    desc = "ATTENTION: the transaction limit is 2.1mil.\nSelect the desired salvage value multiplier.",
                    defv = eTunable.Heist.SalvageYard.Vehicle.SalvageValueMultiplier:Get(),
                    lims = { 0.0, 5.0 },
                    step = 0.1,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Salvage Value Multiplier (Salvage Yard)] 回收价值倍率已更改 ツ")
                    end
                },

                Slot1 = {
                    hash = J("SN_SalvageYard_SelectSlot1"),
                    name = "Sell Value Slot 1",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sell value for the vehicle in slot 1.",
                    defv = eTunable.Heist.SalvageYard.Vehicle.Slot1.Value:Get(),
                    lims = { 0, 2100000 },
                    step = 100000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Value Slot 1 (Salvage Yard)] 1号插槽载具出售价值已更改 ツ")
                    end
                },

                Slot2 = {
                    hash = J("SN_SalvageYard_SelectSlot2"),
                    name = "Sell Value Slot 2",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sell value for the vehicle in slot 2.",
                    defv = eTunable.Heist.SalvageYard.Vehicle.Slot2.Value:Get(),
                    lims = { 0, 2100000 },
                    step = 100000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Value Slot 2 (Salvage Yard)] 2号插槽载具出售价值已更改 ツ")
                    end
                },

                Slot3 = {
                    hash = J("SN_SalvageYard_SelectSlot3"),
                    name = "Sell Value Slot 3",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sell value for the vehicle in slot 3.",
                    defv = eTunable.Heist.SalvageYard.Vehicle.Slot3.Value:Get(),
                    lims = { 0, 2100000 },
                    step = 100000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Value Slot 3 (Salvage Yard)] 3号插槽载具出售价值已更改 ツ")
                    end
                },

                Apply = {
                    hash = J("SN_SalvageYard_Apply"),
                    name = "Apply Sell Values",
                    type = eFeatureType.Button,
                    desc = "Applies the selected sell values for the vehicles. Also, reloads the planning screen. Use before you start the preparation.",
                    func = function(salvageMultiplier, sellValue1, sellValue2, sellValue3)
                        eTunable.Heist.SalvageYard.Vehicle.SalvageValueMultiplier:Set(salvageMultiplier)
                        eTunable.Heist.SalvageYard.Vehicle.Slot1.Value:Set(sellValue1)
                        eTunable.Heist.SalvageYard.Vehicle.Slot2.Value:Set(sellValue2)
                        eTunable.Heist.SalvageYard.Vehicle.Slot3.Value:Set(sellValue3)
                        eLocal.Heist.SalvageYard.Reload:Set(2)
                        SilentLogger.LogInfo("[Apply Sell Values (Salvage Yard)] 出售价值已生效 ツ")
                    end
                }
            }
        }
    },

    Business = {
        Bunker = {
            Sale = {
                Price = {
                    hash = J("SN_Bunker_Price"),
                    name = "Maximize Price",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nApplies the maximum price for your stock.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if not GTA.IsInSessionAlone() then
                                GTA.EmptySession()
                            end

                            if eStat.MPX_PRODTOTALFORFACTORY5:Get() == 0 then
                                eGlobal.Business.Supplies.Bunker:Set(1)
                                Script.Yield(1000)
                                eGlobal.Business.Bunker.Production.Trigger1:Set(0)
                                eGlobal.Business.Bunker.Production.Trigger2:Set(true)
                            end

                            eTunable.Business.Bunker.Product.Value:Set(math.floor((2500000 / 1.5) / eStat.MPX_PRODTOTALFORFACTORY5:Get()))
                            eTunable.Business.Bunker.Product.StaffUpgraded:Set(0)
                            eTunable.Business.Bunker.Product.EquipmentUpgraded:Set(0)

                            if not loggedBunkerPrice then
                                SilentLogger.LogInfo("[Maximize Price (Bunker)] 货物价格已调至最高 ツ")
                                loggedBunkerPrice = true
                            end
                        else
                            eTunable.Business.Bunker.Product.Value:Reset()
                            eTunable.Business.Bunker.Product.StaffUpgraded:Reset()
                            eTunable.Business.Bunker.Product.EquipmentUpgraded:Reset()
                            SilentLogger.LogInfo("[Maximize Price (Bunker)] 货物价格已重置 ツ")
                            loggedBunkerPrice = false
                        end
                    end
                },

                                NoXp = {
                    hash = J("SN_Bunker_NoXp"),
                    name = "No XP Gain",
                    type = eFeatureType.Toggle,
                    desc = "Disables the xp gain for sell missions.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[No XP Gain (Bunker)] 经验获取已%s ツ", (ftr:IsToggled()) and "禁用" or "启用"))
                    end
                },

                Sell = {
                    hash = J("SN_Bunker_Sell"),
                    name = "Instant Sell",
                    type = eFeatureType.Button,
                    desc = "Finishes the sell mission instantly. Use after you can see the minimap.",
                    func = function(bool)
                        eTunable.World.Multiplier.Xp:Set((bool) and 0.0 or 1.0)
                        eLocal.Business.Bunker.Sell.Finish:Set(0)
                        SilentLogger.LogInfo("[Instant Sell (Bunker)] 出售任务已完成 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_Bunker_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Bunker's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Bunker)
                            SilentLogger.LogInfo("[Teleport to Entrance (Bunker)] 你已被传送至地堡入口 ツ")
                        end
                    },

                    Laptop = {
                        hash = J("SN_Bunker_Laptop"),
                        name = "Teleport to Laptop",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Bunker's laptop.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Bunker))
                            SilentLogger.LogInfo("[Teleport to Laptop (Bunker)] 你已被传送至地堡笔记本电脑处 ツ")
                        end
                    }
                },

                Open = {
                    hash = J("SN_Bunker_Open"),
                    name = "Open Laptop",
                    type = eFeatureType.Button,
                    desc = "Opens the Bunker's laptop screen.",
                    func = function()
                        GTA.StartScript(eScript.Bunker.Laptop)
                        SilentLogger.LogInfo("[Open Laptop (Bunker)] 地堡笔记本电脑界面已打开 ツ")
                    end
                },

                Supply = {
                    hash = J("SN_Bunker_Supply"),
                    name = "Get Supplies",
                    type = eFeatureType.Button,
                    desc = "Gets supplies for your Bunker.",
                    func = function()
                        eGlobal.Business.Supplies.Bunker:Set(1)
                        SilentLogger.LogInfo("[Get Supplies (Bunker)] 地堡补给已获取 ツ")
                    end
                },

                Trigger = {
                    hash = J("SN_Bunker_Trigger"),
                    name = "Trigger Production",
                    type = eFeatureType.Button,
                    desc = "Triggers production of your stock.",
                    func = function()
                        if not GTA.IsScriptRunning(eScript.Bunker.Laptop) then
                            eGlobal.Business.Bunker.Production.Trigger1:Set(0)
                            eGlobal.Business.Bunker.Production.Trigger2:Set(true)
                            SilentLogger.LogInfo("[Trigger Production (Bunker)] 货物生产已触发 ツ")
                        end
                    end
                },

                Supplier = {
                    hash = J("SN_Bunker_Supplier"),
                    name = "Turkish Supplier",
                    type = eFeatureType.Toggle,
                    desc = "Fills your Bunker stock. Also, gets supplies for your Bunker repeatedly.",
                    func = function(ftr)
                        if not GTA.IsScriptRunning(eScript.Bunker.Laptop) then
                            if ftr:IsToggled() then
                                eGlobal.Business.Supplies.Bunker:Set(1)
                                eGlobal.Business.Bunker.Production.Trigger1:Set(0)
                                eGlobal.Business.Bunker.Production.Trigger2:Set(true)

                                if not loggedBunkerSupplier then
                                    SilentLogger.LogInfo("[Turkish Supplier (Bunker)] 土耳其供应商已启用 ツ")
                                    loggedBunkerSupplier = true
                                end

                                Script.Yield(1000)
                            else
                                eGlobal.Business.Supplies.Bunker:Set(0)
                                SilentLogger.LogInfo("[Turkish Supplier (Bunker)] 土耳其供应商已禁用 ツ")
                            end

                        end
                    end
                }
            },

            Stats = {
                SellMade = {
                    hash = J("SN_Bunker_SellMade"),
                    name = "Sell Made",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales made.",
                    defv = eStat.MPX_LIFETIME_BKR_SEL_COMPLETBC5:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Made (Bunker)] 出售次数已更改。别忘了应用更改 ツ")
                    end
                },

                SellUndertaken = {
                    hash = J("SN_Bunker_Undertaken"),
                    name = "Sell Undertaken",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales undertaken.",
                    defv = eStat.MPX_LIFETIME_BKR_SEL_UNDERTABC5:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Undertaken (Bunker)] 承接出售次数已更改。别忘了应用更改 ツ")
                    end
                },

                Earnings = {
                    hash = J("SN_Bunker_Earnings"),
                    name = "Earnings",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired earnings.",
                    defv = eStat.MPX_LIFETIME_BKR_SELL_EARNINGS5:Get(),
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Earnings (Bunker)] 收益金额已更改。别忘了应用更改 ツ")
                    end
                },

                NoSell = {
                    hash = J("SN_Bunker_NoSell"),
                    name = "Don't Apply Sell",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new sell missions or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Sell (Bunker)] 出售设置已选择：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                NoEarnings = {
                    hash = J("SN_Bunker_NoEarnings"),
                    name = "Don't Apply Earnings",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new earnings or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Earnings (Bunker)] 收益设置已选择：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                Apply = {
                    hash = J("SN_Bunker_Apply"),
                    name = "Apply All Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes.",
                    func = function(bool1, bool2, sellMade, sellUndertaken, earnings)
                        if not bool1 then
                            eStat.MPX_LIFETIME_BKR_SEL_COMPLETBC5:Set(sellMade)
                            eStat.MPX_LIFETIME_BKR_SEL_UNDERTABC5:Set(sellUndertaken)
                            eStat.MPX_BUNKER_UNITS_MANUFAC:Set(sellMade * 100)
                        end
                        if not bool2 then
                            eStat.MPX_LIFETIME_BKR_SELL_EARNINGS5:Set(earnings)
                        end
                        SilentLogger.LogInfo("[Apply All Changes (Bunker)] 所有更改已生效 ツ")
                    end
                }
            }
        },

        Hangar = {
            Sale = {
                Price = {
                    hash = J("SN_Hangar_Price"),
                    name = "Maximize Price",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, no bans reported.\nApplies the maximum price for your cargo.",
                    func = function(ftr)
                        if not GTA.IsScriptRunning(eScript.Hangar.Sell) then
                            if ftr:IsToggled() then
                                if not GTA.IsInSessionAlone() then
                                    GTA.EmptySession()
                                end

                                if eStat.MPX_HANGAR_CONTRABAND_TOTAL:Get() < 4 then
                                    ePackedStat.Business.Hangar.Cargo:Set(true)
                                    Script.Yield(1000)
                                end

                                eTunable.Business.Hangar.Price:Set(math.floor(4000000 / eStat.MPX_HANGAR_CONTRABAND_TOTAL:Get()))
                                eTunable.Business.Hangar.RonsCut:Set(0.0)

                                if not loggedHangarPrice then
                                    SilentLogger.LogInfo("[Maximize Price (Hangar)] 货物价格已调至最高 ツ")
                                    loggedHangarPrice = true
                                end
                            else
                                eTunable.Business.Hangar.Price:Reset()
                                eTunable.Business.Hangar.RonsCut:Reset()
                                SilentLogger.LogInfo("[Maximize Price (Hangar)] 货物价格已重置 ツ")
                                loggedHangarPrice = false
                            end
                        end
                    end
                },

                NoXp = {
                    hash = J("SN_Hangar_NoXp"),
                    name = "No XP Gain",
                    type = eFeatureType.Toggle,
                    desc = "Disables the xp gain for sell missions.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[No XP Gain (Hangar)] 经验获取已%s ツ", (ftr:IsToggled()) and "禁用" or "启用"))
                    end
                },

                Sell = {
                    hash = J("SN_Hangar_Sell"),
                    name = "Instant Air Cargo Sell",
                    type = eFeatureType.Button,
                    desc = "Finishes the air cargo sell mission instantly. Use after you can see the minimap.",
                    func = function(bool)
                        eTunable.World.Multiplier.Xp:Set((bool) and 0.0 or 1.0)
                        eLocal.Business.Hangar.Sell.ToDeliver:Set(eLocal.Business.Hangar.Sell.Delivered:Get())
                        SilentLogger.LogInfo("[Instant Air Cargo Sell (Hangar)] 空运货物出售任务已完成 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                }
            },

            Misc = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_Hangar_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Hangar's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Hangar)
                            SilentLogger.LogInfo("[Teleport to Entrance (Hangar)] 你已被传送至机库入口 ツ")
                        end
                    },

                    Laptop = {
                        hash = J("SN_Hangar_Laptop"),
                        name = "Teleport to Laptop",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Hangar's laptop.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Hangar))
                            SilentLogger.LogInfo("[Teleport to Laptop (Hangar)] 你已被传送至机库笔记本电脑处 ツ")
                        end
                    }
                },

                Open = {
                    hash = J("SN_Hangar_Open"),
                    name = "Open Laptop",
                    type = eFeatureType.Button,
                    desc = "Opens the Hangar's laptop screen.",
                    func = function()
                        GTA.StartScript(eScript.Hangar.Laptop)
                        SilentLogger.LogInfo("[Open Laptop (Hangar)] 机库笔记本电脑界面已打开 ツ")
                    end
                },

                Supply = {
                    hash = J("SN_Hangar_Supply"),
                    name = "Get Cargo",
                    type = eFeatureType.Button,
                    desc = "Gets cargo for your Hangar.",
                    func = function()
                        if not GTA.IsScriptRunning(eScript.Hangar.Laptop) then
                            ePackedStat.Business.Hangar.Cargo:Set(true)
                            SilentLogger.LogInfo("[Get Cargo (Hangar)] 机库货物已获取 ツ")
                        end
                    end
                },

                Supplier = {
                    hash = J("SN_Hangar_Supplier"),
                    name = "Turkish Supplier",
                    type = eFeatureType.Toggle,
                    desc = "Fills your Hangar stock repeatedly.",
                    func = function(ftr)
                        if not GTA.IsScriptRunning(eScript.Hangar.Laptop) then
                            if ftr:IsToggled() then
                                ePackedStat.Business.Hangar.Cargo:Set(true)

                                if not loggedHangarSupplier then
                                    SilentLogger.LogInfo("[Turkish Supplier (Hangar)] 土耳其供应商已启用 ツ")
                                    loggedHangarSupplier = true
                                end

                                Script.Yield(1000)
                            else
                                SilentLogger.LogInfo("[Turkish Supplier (Hangar)] 土耳其供应商已禁用 ツ")
                                loggedHangarSupplier = false
                            end
                        end
                    end
                },

                Cooldown = {
                    hash = J("SN_Hangar_Cooldown"),
                    name = "Kill Cooldowns",
                    type = eFeatureType.Toggle,
                    desc = "Skips almost all cooldowns.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            eTunable.Business.Hangar.Cooldown.Steal.Easy:Set(0)
                            eTunable.Business.Hangar.Cooldown.Steal.Medium:Set(0)
                            eTunable.Business.Hangar.Cooldown.Steal.Hard:Set(0)
                            eTunable.Business.Hangar.Cooldown.Steal.Additional:Set(0)
                            eTunable.Business.Hangar.Cooldown.Sell:Set(0)

                            if not loggedHangarCooldown then
                                SilentLogger.LogInfo("[Kill Cooldowns (Hangar)] 冷却时间已清除 ツ")
                                loggedHangarCooldown = true
                            end
                        else
                            eTunable.Business.Hangar.Cooldown.Steal.Easy:Reset()
                            eTunable.Business.Hangar.Cooldown.Steal.Medium:Reset()
                            eTunable.Business.Hangar.Cooldown.Steal.Hard:Reset()
                            eTunable.Business.Hangar.Cooldown.Steal.Additional:Reset()
                            eTunable.Business.Hangar.Cooldown.Sell:Reset()
                            SilentLogger.LogInfo("[Kill Cooldowns (Hangar)] 冷却时间已重置 ツ")
                            loggedHangarCooldown = false
                        end
                    end
                }
            },

            Stats = {
                BuyMade = {
                    hash = J("SN_Hangar_BuyMade"),
                    name = "Buy Made",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired buy made.",
                    defv = eStat.MPX_LFETIME_HANGAR_BUY_COMPLET:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Buy Made (Hangar)] 购买次数已更改。别忘了应用更改 ツ")
                    end
                },

                BuyUndertaken = {
                    hash = J("SN_Hangar_BuyUndertaken"),
                    name = "Buy Undertaken",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired buy undertaken.",
                    defv = eStat.MPX_LFETIME_HANGAR_BUY_UNDETAK:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Buy Undertaken (Hangar)] 承接购买次数已更改。别忘了应用更改 ツ")
                    end
                },

                SellMade = {
                    hash = J("SN_Hangar_SellMade"),
                    name = "Sell Made",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales made.",
                    defv = eStat.MPX_LFETIME_HANGAR_SEL_COMPLET:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Made (Hangar)] 出售次数已更改。别忘了应用更改 ツ")
                    end
                },

                SellUndertaken = {
                    hash = J("SN_Hangar_SellUndertaken"),
                    name = "Sell Undertaken",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales undertaken.",
                    defv = eStat.MPX_LFETIME_HANGAR_SEL_UNDETAK:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Undertaken (Hangar)] 承接出售次数已更改。别忘了应用更改 ツ")
                    end
                },

                Earnings = {
                    hash = J("SN_Hangar_Earnings"),
                    name = "Earnings",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired earnings.",
                    defv = eStat.MPX_LFETIME_HANGAR_EARNINGS:Get(),
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Earnings (Hangar)] 收益金额已更改。别忘了应用更改 ツ")
                    end
                },

                NoBuy = {
                    hash = J("SN_Hangar_NoBuy"),
                    name = "Don't Apply Buy",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new buy missions or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Buy (Hangar)] 购买设置已选择：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                NoSell = {
                    hash = J("SN_Hangar_NoSell"),
                    name = "Don't Apply Sell",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new sell missions or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Sell (Hangar)] 出售设置已选择：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                NoEarnings = {
                    hash = J("SN_Hangar_NoEarnings"),
                    name = "Don't Apply Earnings",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new earnings or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Earnings (Hangar)] 收益设置已选择：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                Apply = {
                    hash = J("SN_Hangar_Apply"),
                    name = "Apply All Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes.",
                    func = function(bool1, bool2, bool3, buyMade, buyUndertaken, sellMade, sellUndertaken, earnings)
                        if not bool1 then
                            eStat.MPX_LFETIME_HANGAR_BUY_COMPLET:Set(buyMade)
                            eStat.MPX_LFETIME_HANGAR_BUY_UNDETAK:Set(buyUndertaken)
                        end
                        if not bool2 then
                            eStat.MPX_LFETIME_HANGAR_SEL_COMPLET:Set(sellMade)
                            eStat.MPX_LFETIME_HANGAR_SEL_UNDETAK:Set(sellUndertaken)
                        end
                        if not bool3 then
                            eStat.MPX_LFETIME_HANGAR_EARNINGS:Set(earnings)
                        end
                        SilentLogger.LogInfo("[Apply All Changes (Hangar)] 所有更改已生效 ツ")
                    end
                }
            }
        },

        MoneyFronts = {
            HandsOnCarWash = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_HandsOnCarWash_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Car Wash's entrance.",
                        func = function()
                            if ePackedStat.Business.Heat.HandsOnCarWash:Get() ~= 100 then
                                GTA.TeleportToBlip(eTable.BlipSprites.CarWash)
                            else
                                GTA.TeleportToBlip(eTable.BlipSprites.CarWashH)
                            end
                            SilentLogger.LogInfo("[Teleport to Entrance (Money Fronts)] 你已被传送至洗车行入口 ツ")
                        end
                    },

                    Laptop = {
                        hash = J("SN_HandsOnCarWash_Laptop"),
                        name = "Teleport to Laptop",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Car Wash's laptop.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.CarWash))
                            SilentLogger.LogInfo("[Teleport to Laptop (Money Fronts)] 你已被传送至洗车行笔记本电脑处 ツ")
                        end
                    }
                },

                Heat = {
                    Lock = {
                        hash = J("SN_HandsOnCarWash_Lock"),
                        name = "Lock",
                        type = eFeatureType.Toggle,
                        desc = "Locks the heat of your Car Wash on the current level.",
                        func = function(ftr)
                            if ftr:IsToggled() then
                                if HOCWHEAT == "TEMP" then
                                    HOCWHEAT = ePackedStat.Business.Heat.HandsOnCarWash:Get()
                                end

                                ePackedStat.Business.Heat.HandsOnCarWash:Set(HOCWHEAT)

                                if not loggedHOCWLock then
                                    SilentLogger.LogInfo(F("[Lock (Money Fronts)] Heat level should've been locked at %d%% ツ", HOCWHEAT))
                                    loggedHOCWLock = true
                                end

                                Script.Yield(1000)
                            else
                                HOCWHEAT = "TEMP"
                                SilentLogger.LogInfo("[Lock (Money Fronts)] Heat level should've been unlocked ツ")
                                loggedHOCWLock = false
                            end
                        end
                    },

                    Max = {
                        hash = J("SN_HandsOnCarWash_Max"),
                        name = "Max",
                        type = eFeatureType.Button,
                        desc = "Makes your Car Wash's heat high.",
                        func = function()
                            ePackedStat.Business.Heat.HandsOnCarWash:Set(100)
                            SilentLogger.LogInfo("[Max (Money Fronts)] Heat level should've been maximized ツ")
                        end
                    },

                    Min = {
                        hash = J("SN_HandsOnCarWash_Min"),
                        name = "Min",
                        type = eFeatureType.Button,
                        desc = "Makes your Car Wash's heat low.",
                        func = function()
                            ePackedStat.Business.Heat.HandsOnCarWash:Set(0)
                            SilentLogger.LogInfo("[Min (Money Fronts)] Heat level should've been minimized ツ")
                        end
                    },

                    Select = {
                        hash = J("SN_HandsOnCarWash_Select"),
                        name = "Heat Percentage",
                        type = eFeatureType.SliderInt,
                        desc = "Select the desired Car Wash's heat level.",
                        defv = 0,
                        lims = { 0, 100 },
                        func = function(ftr)
                            ePackedStat.Business.Heat.HandsOnCarWash:Set(ftr:GetIntValue())
                            SilentLogger.LogInfo("[Heat Percentage (Money Fronts)] Heat level should've been changed ツ")
                        end
                    }
                }
            },

            SmokeOnTheWater = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_SmokeOnTheWater_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Weed Shop's entrance.",
                        func = function()
                            if ePackedStat.Business.Heat.SmokeOnTheWater:Get() ~= 100 then
                                GTA.TeleportToBlip(eTable.BlipSprites.WeedShop)
                            else
                                GTA.TeleportToBlip(eTable.BlipSprites.WeedShopH)
                            end
                            SilentLogger.LogInfo("[Teleport to Entrance (Money Fronts)] You should've been teleported to the entrance ツ")
                        end
                    },

                    Laptop = {
                        hash = J("SN_SmokeOnTheWater_Laptop"),
                        name = "Teleport to Laptop",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Weed Shop's laptop.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.WeedShop))
                            SilentLogger.LogInfo("[Teleport to Laptop (Money Fronts)] You should've been teleported to the laptop ツ")
                        end
                    }
                },

                Heat = {
                    Lock = {
                        hash = J("SN_SmokeOnTheWaterLock"),
                        name = "Lock",
                        type = eFeatureType.Toggle,
                        desc = "Locks the heat of your Weed Shop on the current level.",
                        func = function(ftr)
                            if ftr:IsToggled() then
                                if SOTWHEAT == "TEMP" then
                                    SOTWHEAT = ePackedStat.Business.Heat.SmokeOnTheWater:Get()
                                end

                                ePackedStat.Business.Heat.SmokeOnTheWater:Set(SOTWHEAT)

                                if not loggedSOTWLock then
                                    SilentLogger.LogInfo(F("[Lock (Money Fronts)] Heat level should've been locked at %d%% ツ", SOTWHEAT))
                                    loggedSOTWLock = true
                                end

                                Script.Yield(1000)
                            else
                                SOTWHEAT = "TEMP"
                                SilentLogger.LogInfo("[Lock (Money Fronts)] Heat level should've been unlocked ツ")
                                loggedSOTWLock = false
                            end
                        end
                    },

                    Max = {
                        hash = J("SN_SmokeOnTheWater_Max"),
                        name = "Max",
                        type = eFeatureType.Button,
                        desc = "Makes your Weed Shop's heat high.",
                        func = function()
                            ePackedStat.Business.Heat.SmokeOnTheWater:Set(100)
                            SilentLogger.LogInfo("[Max (Money Fronts)] Heat level should've been maximized ツ")
                        end
                    },

                    Min = {
                        hash = J("SN_SmokeOnTheWater_Min"),
                        name = "Min",
                        type = eFeatureType.Button,
                        desc = "Makes your Weed Shop's heat low.",
                        func = function()
                            ePackedStat.Business.Heat.SmokeOnTheWater:Set(0)
                            SilentLogger.LogInfo("[Min (Money Fronts)] Heat level should've been minimized ツ")
                        end
                    },

                    Select = {
                        hash = J("SN_SmokeOnTheWater_Select"),
                        name = "Heat Percentage",
                        type = eFeatureType.SliderInt,
                        desc = "Select the desired Weed Shop's heat level.",
                        defv = 0,
                        lims = { 0, 100 },
                        func = function(ftr)
                            ePackedStat.Business.Heat.SmokeOnTheWater:Set(ftr:GetIntValue())
                            SilentLogger.LogInfo("[Heat Percentage (Money Fronts)] Heat level should've been changed ツ")
                        end
                    }
                }
            },

            HigginsHelitours = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_HigginsHelitours_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Tour Company's entrance.",
                        func = function()
                            if ePackedStat.Business.Heat.HigginsHelitours:Get() ~= 100 then
                                GTA.TeleportToBlip(eTable.BlipSprites.TourCompany)
                            else
                                GTA.TeleportToBlip(eTable.BlipSprites.TourCompanyH)
                            end
                            SilentLogger.LogInfo("[Teleport to Entrance (Money Fronts)] You should've been teleported to the entrance ツ")
                        end
                    },

                    Laptop = {
                        hash = J("SN_HigginsHelitours_Laptop"),
                        name = "Teleport to Laptop",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Tour Company's laptop.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.TourCompany))
                            SilentLogger.LogInfo("[Teleport to Laptop (Money Fronts)] You should've been teleported to the laptop ツ")
                        end
                    }
                },

                Heat = {
                    Lock = {
                        hash = J("SN_HigginsHelitours_Lock"),
                        name = "Lock",
                        type = eFeatureType.Toggle,
                        desc = "Locks the heat of your Tour Company on the current level.",
                        func = function(ftr)
                            if ftr:IsToggled() then
                                if HHHEAT == "TEMP" then
                                    HHHEAT = ePackedStat.Business.Heat.HigginsHelitours:Get()
                                end

                                ePackedStat.Business.Heat.HigginsHelitours:Set(HHHEAT)

                                if not loggedHHLock then
                                    SilentLogger.LogInfo(F("[Lock (Money Fronts)] Heat level should've been locked at %d%% ツ", HHHEAT))
                                    loggedHHLock = true
                                end

                                Script.Yield(1000)
                            else
                                HHHEAT = "TEMP"
                                SilentLogger.LogInfo("[Lock (Money Fronts)] Heat level should've been unlocked ツ")
                                loggedHHLock = false
                            end
                        end
                    },

                    Max = {
                        hash = J("SN_HigginsHelitours_Max"),
                        name = "Max",
                        type = eFeatureType.Button,
                        desc = "Makes your Tour Company's heat high.",
                        func = function()
                            ePackedStat.Business.Heat.HigginsHelitours:Set(100)
                            SilentLogger.LogInfo("[Max (Money Fronts)] Heat level should've been maximized ツ")
                        end
                    },

                    Min = {
                        hash = J("SN_HigginsHelitours_Min"),
                        name = "Min",
                        type = eFeatureType.Button,
                        desc = "Makes your Tour Company's heat low.",
                        func = function()
                            ePackedStat.Business.Heat.HigginsHelitours:Set(0)
                            SilentLogger.LogInfo("[Min (Money Fronts)] Heat level should've been minimized ツ")
                        end
                    },

                    Select = {
                        hash = J("SN_HigginsHelitours_Select"),
                        name = "Heat Percentage",
                        type = eFeatureType.SliderInt,
                        desc = "Select the desired Tour Company's heat level.",
                        defv = 0,
                        lims = { 0, 100 },
                        func = function(ftr)
                            ePackedStat.Business.Heat.HigginsHelitours:Set(ftr:GetIntValue())
                            SilentLogger.LogInfo("[Heat Percentage (Money Fronts)] Heat level should've been changed ツ")
                        end
                    }
                }
            },

            OverallHeat = {
                Lock = {
                    hash = J("SN_OverallHeat_Lock"),
                    name = "Lock",
                    type = eFeatureType.Toggle,
                    desc = "Locks the heat of all businesses on the current level."
                },

                Max = {
                    hash = J("SN_OverallHeat_Max"),
                    name = "Max",
                    type = eFeatureType.Button,
                    desc = "Makes the heat of all businesses high."
                },

                Min = {
                    hash = J("SN_OverallHeat_Min"),
                    name = "Min",
                    type = eFeatureType.Button,
                    desc = "Makes the heat of all businesses low."
                },

                Select = {
                    hash = J("SN_OverallHeat_Select"),
                    name = "Heat Percentage",
                    type = eFeatureType.SliderInt,
                    desc = "Select the desired overall heat level.",
                    defv = 0,
                    lims = { 0, 100 },
                    func = function(ftr)
                        ePackedStat.Business.Heat.HandsOnCarWash:Set(ftr:GetIntValue())
                        ePackedStat.Business.Heat.SmokeOnTheWater:Set(ftr:GetIntValue())
                        ePackedStat.Business.Heat.HigginsHelitours:Set(ftr:GetIntValue())
                        SilentLogger.LogInfo("[Heat Percentage (Money Fronts)] Heat level should've been changed ツ")
                    end
                }
            }
        },

        Nightclub = {
            Sale = {
                Price = {
                    hash = J("SN_Nightclub_Price"),
                    name = "Maximize Price",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nApplies the maximum price for goods. Don't sell «All Goods».",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if not GTA.IsInSessionAlone() then
                                GTA.EmptySession()
                            end

                            local price = 4000000

                            eTunable.Business.Nightclub.Price.Weapons:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_1:Get()))
                            eTunable.Business.Nightclub.Price.Coke:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_2:Get()))
                            eTunable.Business.Nightclub.Price.Meth:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_3:Get()))
                            eTunable.Business.Nightclub.Price.Weed:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_4:Get()))
                            eTunable.Business.Nightclub.Price.Documents:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_5:Get()))
                            eTunable.Business.Nightclub.Price.Cash:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_6:Get()))
                            eTunable.Business.Nightclub.Price.Cargo:Set(math.floor(price / eStat.MPX_HUB_PROD_TOTAL_0:Get()))

                            if not loggedNightclubPrice then
                                SilentLogger.LogInfo("[Maximize Price (Nightclub)] Price should've been maximized ツ")
                                loggedNightclubPrice = true
                            end
                        else
                            eTunable.Business.Nightclub.Price.Weapons:Reset()
                            eTunable.Business.Nightclub.Price.Coke:Reset()
                            eTunable.Business.Nightclub.Price.Meth:Reset()
                            eTunable.Business.Nightclub.Price.Weed:Reset()
                            eTunable.Business.Nightclub.Price.Documents:Reset()
                            eTunable.Business.Nightclub.Price.Cash:Reset()
                            eTunable.Business.Nightclub.Price.Cargo:Reset()
                            SilentLogger.LogInfo("[Maximize Price (Nightclub)] Price should've been reset ツ")
                            loggedNightclubPrice = false
                        end
                    end
                }
            },

            Misc = {
                Setup = {
                    hash = J("SN_Nightclub_Setup"),
                    name = "Skip Setups",
                    type = eFeatureType.Button,
                    desc = "Skips the setup missions for your Nightclub. Change the session to apply.",
                    func = function()
                        ePackedStat.Business.Nightclub.Setup.Staff:Set(true)
                        ePackedStat.Business.Nightclub.Setup.Equipment:Set(true)
                        ePackedStat.Business.Nightclub.Setup.DJ:Set(true)
                        SilentLogger.LogInfo("[Skip Setup (Nightclub)] Setups should've been skipped. Don't forget to change the session ツ")
                    end
                },

                Teleport = {
                    Entrance = {
                        hash = J("SN_Nightclub_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Nightclub's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Nightclub)
                            SilentLogger.LogInfo("[Teleport to Entrance (Nightclub)] You should've been teleported to the entrance ツ")
                        end
                    },

                    Computer = {
                        hash = J("SN_Nightclub_Computer"),
                        name = "Teleport to Computer",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Nightclub's computer.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Nightclub))
                            SilentLogger.LogInfo("[Teleport to Computer (Nightclub)] You should've been teleported to the computer ツ")
                        end
                    }
                },

                Open = {
                    hash = J("SN_Nightclub_Open"),
                    name = "Open Computer",
                    type = eFeatureType.Button,
                    desc = "Opens the Nightclub's computer screen.",
                    func = function()
                        GTA.StartScript(eScript.Nightclub.Laptop)
                        SilentLogger.LogInfo("[Open Computer (Nightclub)] Computer screen should've been opened ツ")
                    end
                },

                Cooldown = {
                    hash = J("SN_Nighclub_Cooldown"),
                    name = "Kill Cooldowns",
                    type = eFeatureType.Toggle,
                    desc = "Skips almost all cooldowns.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            eTunable.Business.Nightclub.Cooldown.ClubManagement:Set(0)
                            eTunable.Business.Nightclub.Cooldown.Sell:Set(0)
                            eTunable.Business.Nightclub.Cooldown.SellDelivery:Set(0)

                            if not loggedNightclubCooldown then
                                SilentLogger.LogInfo("[Kill Cooldowns (Nightclub)] Cooldowns should've been killed ツ")
                                loggedNightclubCooldown = true
                            end
                        else
                            eTunable.Business.Nightclub.Cooldown.ClubManagement:Reset()
                            eTunable.Business.Nightclub.Cooldown.Sell:Reset()
                            eTunable.Business.Nightclub.Cooldown.SellDelivery:Reset()
                            SilentLogger.LogInfo("[Kill Cooldowns (Nightclub)] Cooldowns should've been reset ツ")
                            loggedNightclubCooldown = false
                        end
                    end
                }
            },

            Stats = {
                SellMade = {
                    hash = J("SN_Nightclub_SellMade"),
                    name = "Sell Made",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales made.",
                    defv = eStat.MPX_HUB_SALES_COMPLETED:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Made (Nightclub)] Sales made should've been changed. Don't forget to apply ツ")
                    end
                },

                Earnings = {
                    hash = J("SN_Nightclub_Earnings"),
                    name = "Earnings",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired earnings.",
                    defv = eStat.MPX_HUB_EARNINGS:Get(),
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Earnings (Nightclub)] Earnings should've been changed. Don't forget to apply ツ")
                    end
                },

                NoSell = {
                    hash = J("SN_Nightclub_NoSell"),
                    name = "Don't Apply Sell",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new sell missions or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Sell (Nightclub)] Selected sell: %s ツ", (ftr:IsToggled()) and "Don't Apply" or "Apply"))
                    end
                },

                NoEarnings = {
                    hash = J("SN_Nightclub_NoEarnings"),
                    name = "Don't Apply Earnings",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new earnings or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Earnings (Nightclub)] Selected earnings: %s ツ", (ftr:IsToggled()) and "Don't Apply" or "Apply"))
                    end
                },

                Apply = {
                    hash = J("SN_Nightclub_Apply"),
                    name = "Apply All Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes.",
                    func = function(bool1, bool2, buyMade, earnings)
                        if not bool1 then
                            eStat.MPX_HUB_SALES_COMPLETED:Set(buyMade)
                        end
                        if not bool2 then
                            eStat.MPX_HUB_EARNINGS:Set(earnings)
                        end
                        SilentLogger.LogInfo("[Apply All Changes (Nightclub)] Changes should've been applied ツ")
                    end
                }
            },

            Safe = {
                Fill = {
                    hash = J("SN_Nightclub_Fill"),
                    name = "Fill",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: might be unsafe, if overused.\nFills your Nightclub safe with money.",
                    func = function()
                        local top5     = eGlobal.Business.Nightclub.Safe.Income.Top5.global
                        local top100   = eGlobal.Business.Nightclub.Safe.Income.Top100.global
                        local maxValue = 300000

                        eTunable.Business.Nightclub.Safe.MaxCapacity:Set(maxValue)

                        for i = top5, top100 do
                            ScriptGlobal.SetInt(i, maxValue)
                        end

                        eStat.MPX_CLUB_PAY_TIME_LEFT:Set(-1)
                        SilentLogger.LogInfo("[Fill Safe (Nightclub)] Safe should've been filled ツ")
                    end
                },

                Collect = {
                    hash = J("SN_Nightclub_Collect"),
                    name = "Collect",
                    type = eFeatureType.Button,
                    desc = F("ATTENTION: might be unsafe, if overused.\nCollects money from your Nightclub safe.%s", (GTA_EDITION == "LE") and " Use inside your Nightclub." or ""),
                    func = function()
                        if eGlobal.Business.Nightclub.Safe.Value:Get() > 0 then
                            if GTA_EDITION == "EE" then
                                eGlobal.Business.Nightclub.Safe.Collect:Set(true)
                            else
                                eLocal.Business.Nightclub.Safe.Type:Set(3)
                                eLocal.Business.Nightclub.Safe.Collect:Set(1)
                            end
                            SilentLogger.LogInfo("[Collect Safe (Nightclub)] Safe should've been collected ツ", eToastPos.BOTTOM_RIGHT)
                        end
                    end
                },

                Unbrick = {
                    hash = J("SN_Nightclub_Unbrick"),
                    name = "Unbrick",
                    type = eFeatureType.Button,
                    desc = F("Unbricks your safe if it shows a dollar sign with $0 inside.%s", (GTA_EDITION == "LE") and " Use inside your Nightclub." or ""),
                    func = function()
                        local top5   = eGlobal.Business.Nightclub.Safe.Income.Top5.global
                        local top100 = eGlobal.Business.Nightclub.Safe.Income.Top100.global

                        for i = top5, top100 do
                            ScriptGlobal.SetInt(i, 1)
                        end

                        eStat.MPX_CLUB_PAY_TIME_LEFT:Set(-1)
                        Script.Yield(3000)

                        if GTA_EDITION == "EE" then
                            eGlobal.Business.Nightclub.Safe.Collect:Set(true)
                        else
                            eLocal.Business.Nightclub.Safe.Type:Set(3)
                            eLocal.Business.Nightclub.Safe.Collect:Set(1)
                        end

                        SilentLogger.LogInfo("[Unbrick Safe (Nightclub)] 保险箱已解锁 ツ")
                    end
                }
            },

            Popularity = {
                Lock = {
                    hash = J("SN_Nightclub_Lock"),
                    name = "Lock",
                    type = eFeatureType.Toggle,
                    desc = "Locks the popularity of your Nightclub on the current level.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if NPOPULARITY == "TEMP" then
                                NPOPULARITY = eStat.MPX_CLUB_POPULARITY:Get()
                            end

                            eStat.MPX_CLUB_POPULARITY:Set(NPOPULARITY)

                            if not loggedNightclubLock then
                                SilentLogger.LogInfo(F("[Lock (Nightclub)] 人气已锁定在 %d%% ツ", NPOPULARITY / 10))
                                loggedNightclubLock = true
                            end

                            Script.Yield(1000)
                        else
                            NPOPULARITY = "TEMP"
                            SilentLogger.LogInfo("[Lock (Nightclub)] 人气已解锁 ツ")
                            loggedNightclubLock = false
                        end
                    end
                },

                Max = {
                    hash = J("SN_Nightclub_Max"),
                    name = "Max",
                    type = eFeatureType.Button,
                    desc = "Makes your Nightclub popular.",
                    func = function()
                        eStat.MPX_CLUB_POPULARITY:Set(1000)
                        SilentLogger.LogInfo("[Max (Nightclub)] 人气已调至最高 ツ")
                    end
                },

                Min = {
                    hash = J("SN_Nightclub_Min"),
                    name = "Min",
                    type = eFeatureType.Button,
                    desc = "Makes your Nightclub unpopular.",
                    func = function()
                        eStat.MPX_CLUB_POPULARITY:Set(0)
                        SilentLogger.LogInfo("[Min (Nightclub)] 人气已调至最低 ツ")
                    end
                },

                Select = {
                    hash = J("SN_Nightclub_Select"),
                    name = "Percentage",
                    type = eFeatureType.SliderInt,
                    desc = "Select the desired Nightclub's popularity level.",
                    defv = 0,
                    lims = { 0, 100 },
                    func = function(ftr)
                        eStat.MPX_CLUB_POPULARITY:Set(ftr:GetIntValue() * 10)
                        SilentLogger.LogInfo("[Percentage (Nightclub)] 人气等级已更改 ツ")
                    end
                }
            }
        },

        CrateWarehouse = {
            Sale = {
                Price = {
                    hash = J("SN_CrateWarehouse_Price"),
                    name = "Maximize Price",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nApplies the maximum price for your crates.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            if not GTA.IsInSessionAlone() then
                                GTA.EmptySession()
                            end

                            local price = 6000000

                            eTunable.Business.CrateWarehouse.Price.Threshold1:Set(price)
                            eTunable.Business.CrateWarehouse.Price.Threshold2:Set(math.floor(price / 2))
                            eTunable.Business.CrateWarehouse.Price.Threshold3:Set(math.floor(price / 3))
                            eTunable.Business.CrateWarehouse.Price.Threshold4:Set(math.floor(price / 5))
                            eTunable.Business.CrateWarehouse.Price.Threshold5:Set(math.floor(price / 7))
                            eTunable.Business.CrateWarehouse.Price.Threshold6:Set(math.floor(price / 9))
                            eTunable.Business.CrateWarehouse.Price.Threshold7:Set(math.floor(price / 14))
                            eTunable.Business.CrateWarehouse.Price.Threshold8:Set(math.floor(price / 19))
                            eTunable.Business.CrateWarehouse.Price.Threshold9:Set(math.floor(price / 24))
                            eTunable.Business.CrateWarehouse.Price.Threshold10:Set(math.floor(price / 29))
                            eTunable.Business.CrateWarehouse.Price.Threshold11:Set(math.floor(price / 34))
                            eTunable.Business.CrateWarehouse.Price.Threshold12:Set(math.floor(price / 39))
                            eTunable.Business.CrateWarehouse.Price.Threshold13:Set(math.floor(price / 44))
                            eTunable.Business.CrateWarehouse.Price.Threshold14:Set(math.floor(price / 49))
                            eTunable.Business.CrateWarehouse.Price.Threshold15:Set(math.floor(price / 59))
                            eTunable.Business.CrateWarehouse.Price.Threshold16:Set(math.floor(price / 69))
                            eTunable.Business.CrateWarehouse.Price.Threshold17:Set(math.floor(price / 79))
                            eTunable.Business.CrateWarehouse.Price.Threshold18:Set(math.floor(price / 89))
                            eTunable.Business.CrateWarehouse.Price.Threshold19:Set(math.floor(price / 99))
                            eTunable.Business.CrateWarehouse.Price.Threshold20:Set(math.floor(price / 110))
                            eTunable.Business.CrateWarehouse.Price.Threshold21:Set(math.floor(price / 111))

                            if not loggedSpecialPrice then
                                SilentLogger.LogInfo("[Maximize Price (Special Cargo)] 板条箱价格已调至最高 ツ")
                                loggedSpecialPrice = true
                            end
                        else
                            for i = 1, 21 do
                                eTunable.Business.CrateWarehouse.Price[F("Threshold%d", i)]:Reset()
                            end
                            SilentLogger.LogInfo("[Maximize Price (Special Cargo)] 板条箱价格已重置 ツ")
                            loggedSpecialPrice = false
                        end
                    end
                },

                NoXp = {
                    hash = J("SN_CrateWarehouse_NoXp"),
                    name = "No XP Gain",
                    type = eFeatureType.Toggle,
                    desc = "Disables the xp gain for sell missions.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[No XP Gain (Special Cargo)] 经验获取已%s ツ", (ftr:IsToggled()) and "禁用" or "启用"))
                    end
                },

                NoCrateback = {
                    hash = J("SN_CrateWarehouse_NoCrateback"),
                    name = "No CrateBack",
                    type = eFeatureType.Toggle,
                    desc = "Disables auto refill of the crates after «Instant Sell».",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[No CrateBack (Special Cargo)] 板条箱自动补充已%s ツ", (ftr:IsToggled()) and "禁用" or "启用"))
                    end
                },

                Sell = {
                    hash = J("SN_CrateWarehouse_Sell"),
                    name = "Instant Sell",
                    type = eFeatureType.Button,
                    desc = "Finishes the sell mission instantly. Use after you can see the minimap.",
                    func = function(bool1, bool2)
                        if not bool2 then
                            if GTA.IsScriptRunning(eScript.CrateWarehouse.Sell) then
                                ePackedStat.Business.CrateWarehouse.Cargo:Set(true)
                            end
                        end
                        eTunable.World.Multiplier.Xp:Set((bool1) and 0.0 or 1.0)
                        eLocal.Business.CrateWarehouse.Sell.Type:Set(7)
                        eLocal.Business.CrateWarehouse.Sell.Finish:Set(99999)
                        Script.Yield(2000)
                        eLocal.Business.CrateWarehouse.Sell.Finish:Set(99999)
                        SilentLogger.LogInfo("[Instant Sell (Special Cargo)] 出售任务已完成 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                }
            },

            Misc = {
                Teleport = {
                    Office = {
                        hash = J("SN_CrateWarehouse_Office"),
                        name = "Teleport to Office",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Office's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Office)
                            SilentLogger.LogInfo("[Teleport to Office (Special Cargo)] 你已被传送至办公室 ツ")
                        end
                    },

                    Computer = {
                        hash = J("SN_CrateWarehouse_Computer"),
                        name = "Teleport to Computer",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Office's computer.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Office))
                            SilentLogger.LogInfo("[Teleport to Computer (Special Cargo)] 你已被传送至办公室电脑处 ツ")
                        end
                    },

                    Warehouse = {
                        hash = J("SN_CrateWarehouse_Warehouse"),
                        name = "Teleport to Warehouse",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the closest Crate Warehouse's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Warehouse)
                            SilentLogger.LogInfo("[Teleport to Warehouse (Special Cargo)] 你已被传送至仓库 ツ")
                        end
                    }
                },

                Supply = {
                    hash = J("SN_CrateWarehouse_Supply"),
                    name = "Get Crates",
                    type = eFeatureType.Button,
                    desc = "Gets some crates for your Crate Warehouses.",
                    func = function()
                        ePackedStat.Business.CrateWarehouse.Cargo:Set(true)
                        SilentLogger.LogInfo("[Get Crates (Special Cargo)] 板条箱已获取 ツ")
                    end
                },

                Select = {
                    hash = J("SN_CrateWarehouse_Select"),
                    name = "Crates Amount",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired crates amount to buy.",
                    defv = 0,
                    lims = { 0, 111 },
                    step = 1,
                    func = function()
                        SilentLogger.LogInfo("[Crates Amount (Special Cargo)] 板条箱数量已更改 ツ")
                    end
                },

                Max = {
                    hash = J("SN_CrateWarehouse_Max"),
                    name = "Max",
                    type = eFeatureType.Button,
                    desc = "Maximizes the crates amount, but not buying them.",
                    func = function()
                        SilentLogger.LogInfo("[Max (Special Cargo)] 板条箱数量已调至上限。别忘了购买 ツ")
                    end
                },

                Buy = {
                    hash = J("SN_CrateWarehouse_Buy"),
                    name = "Instant Buy",
                    type = eFeatureType.Button,
                    desc = "Finishes the buy mission instantly. Use after you can see the minimap.",
                    func = function(amount)
                        eLocal.Business.CrateWarehouse.Buy.Amount:Set(amount)
                        eLocal.Business.CrateWarehouse.Buy.Finish1:Set(1)
                        eLocal.Business.CrateWarehouse.Buy.Finish2:Set(6)
                        eLocal.Business.CrateWarehouse.Buy.Finish3:Set(4)
                        SilentLogger.LogInfo("[Instant Buy (Special Cargo)] 购买任务已完成 ツ")
                    end
                },

                Supplier = {
                    hash = J("SN_CrateWarehouse_Supplier"),
                    name = "Turkish Supplier",
                    type = eFeatureType.Toggle,
                    desc = "Fills your Crate Warehouse stock repeatedly.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            ePackedStat.Business.CrateWarehouse.Cargo:Set(true)

                            if not loggedSpecialSupplier then
                                SilentLogger.LogInfo("[Turkish Supplier (Special Cargo)] 土耳其供应商已启用 ツ")
                                loggedSpecialSupplier = true
                            end

                            Script.Yield(1000)
                        else
                            SilentLogger.LogInfo("[Turkish Supplier (Special Cargo)] 土耳其供应商已禁用 ツ")
                            loggedSpecialSupplier = false
                        end
                    end
                },

                Cooldown = {
                    hash = J("SN_CrateWarehouse_Cooldown"),
                    name = "Kill Cooldowns",
                    type = eFeatureType.Toggle,
                    desc = "Skips almost all cooldowns.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            eTunable.Business.CrateWarehouse.Cooldown.Buy:Set(0)
                            eTunable.Business.CrateWarehouse.Cooldown.Sell:Set(0)

                            if not loggedSpecialCooldown then
                                SilentLogger.LogInfo("[Kill Cooldowns (Special Cargo)] 冷却时间已清除 ツ")
                                loggedSpecialCooldown = true
                            end
                        else
                            eTunable.Business.CrateWarehouse.Cooldown.Buy:Reset()
                            eTunable.Business.CrateWarehouse.Cooldown.Sell:Reset()
                            SilentLogger.LogInfo("[Kill Cooldowns (Special Cargo)] 冷却时间已重置 ツ")
                            loggedSpecialCooldown = false
                        end
                    end
                }
            },

            Stats = {
                BuyMade = {
                    hash = J("SN_CrateWarehouse_BuyMade"),
                    name = "Buy Made",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired buy made.",
                    defv = eStat.MPX_LIFETIME_BUY_COMPLETE:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Buy Made (Special Cargo)] 购买次数已更改。别忘了应用更改 ツ")
                    end
                },

                BuyUndertaken = {
                    hash = J("SN_CrateWarehouse_BuyUndertaken"),
                    name = "Buy Undertaken",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired buy undertaken.",
                    defv = eStat.MPX_LIFETIME_BUY_UNDERTAKEN:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Buy Undertaken (Special Cargo)] 承接购买次数已更改。别忘了应用更改 ツ")
                    end
                },

                SellMade = {
                    hash = J("SN_CrateWarehouse_SellMade"),
                    name = "Sell Made",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales made.",
                    defv = eStat.MPX_LIFETIME_SELL_COMPLETE:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Made (Special Cargo)] 出售次数已更改。别忘了应用更改 ツ")
                    end
                },

                SellUndertaken = {
                    hash = J("SN_CrateWarehouse_SellUndertaken"),
                    name = "Sell Undertaken",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired sales undertaken.",
                    defv = eStat.MPX_LIFETIME_SELL_UNDERTAKEN:Get(),
                    lims = { 0, INT32_MAX },
                    step = 10,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Sell Undertaken (Special Cargo)] 承接出售次数已更改。别忘了应用更改 ツ")
                    end
                },

                                Earnings = {
                    hash = J("SN_CrateWarehouse_Earnings"),
                    name = "Earnings",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired earnings.",
                    defv = eStat.MPX_LIFETIME_CONTRA_EARNINGS:Get(),
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Earnings (Special Cargo)] 收益金额已更改。别忘了应用更改 ツ")
                    end
                },

                NoBuy = {
                    hash = J("SN_CrateWarehouse_NoBuy"),
                    name = "Don't Apply Buy",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new buy missions or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Buy (Special Cargo)] 已选择购买设置：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                NoSell = {
                    hash = J("SN_CrateWarehouse_NoSell"),
                    name = "Don't Apply Sell",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new sell missions or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Sell (Special Cargo)] 已选择出售设置：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                NoEarnings = {
                    hash = J("SN_CrateWarehouse_NoEarnings"),
                    name = "Don't Apply Earnings",
                    type = eFeatureType.Toggle,
                    desc = "Decides whether you want to apply new earnings or not.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Don't Apply Earnings (Special Cargo)] 已选择收益设置：%s ツ", (ftr:IsToggled()) and "不应用" or "应用"))
                    end
                },

                Apply = {
                    hash = J("SN_CrateWarehouse_Apply"),
                    name = "Apply All Changes",
                    type = eFeatureType.Button,
                    desc = "Applies all changes.",
                    func = function(bool1, bool2, bool3, buyMade, buyUndertaken, sellMade, sellUndertaken, earnings)
                        if not bool1 then
                            eStat.MPX_LIFETIME_BUY_COMPLETE:Set(buyMade)
                            eStat.MPX_LIFETIME_BUY_UNDERTAKEN:Set(buyUndertaken)
                        end
                        if not bool2 then
                            eStat.MPX_LIFETIME_SELL_COMPLETE:Set(sellMade)
                            eStat.MPX_LIFETIME_SELL_UNDERTAKEN:Set(sellUndertaken)
                        end
                        if not bool3 then
                            eStat.MPX_LIFETIME_CONTRA_EARNINGS:Set(earnings)
                        end
                        SilentLogger.LogInfo("[Apply All Changes (Special Cargo)] 所有更改已应用 ツ")
                    end
                }
            }
        },

        Misc = {
            Supplies = {
                Business = {
                    hash = J("SN_Misc_SuppliesBusiness"),
                    name = "Business",
                    type = eFeatureType.Combo,
                    desc = "Select the desired business.",
                    list = eTable.Business.Supplies,
                    func = function(ftr)
                        local list  = eTable.Business.Supplies
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Business (Misc)] 已选择产业：%s ツ", list:GetName(index)))
                    end
                },

                Resupply = {
                    hash = J("SN_Misc_SuppliesResupply"),
                    name = "Resupply",
                    type = eFeatureType.Button,
                    desc = "Resupplies the selected business.",
                    func = function(business)
                        if business == -1 then
                            SilentLogger.LogError("[Resupply (Misc)] 你必须先选择一个产业 ツ")
                            return
                        end

                        local businesses = {
                            [0] = eGlobal.Business.Supplies.Slot0,
                            [1] = eGlobal.Business.Supplies.Slot1,
                            [2] = eGlobal.Business.Supplies.Slot2,
                            [3] = eGlobal.Business.Supplies.Slot3,
                            [4] = eGlobal.Business.Supplies.Slot4,
                            [5] = eGlobal.Business.Supplies.Bunker,
                            [6] = eGlobal.Business.Supplies.Acid
                        }

                        if business == 7 then
                            for _, index in ipairs(eTable.Business.Supplies:GetIndexes()) do
                                if index ~= 7 then
                                    businesses[index]:Set(1)
                                end
                            end

                            SilentLogger.LogInfo("[Resupply (Misc)] 所有产业已补给 ツ")
                            return
                        end

                        businesses[business]:Set(1)
                        SilentLogger.LogInfo("[Resupply (Misc)] 该产业已补给 ツ")
                    end
                },

                Refresh = {
                    hash = J("SN_Misc_SuppliesRefresh"),
                    name = "Refresh",
                    type = eFeatureType.Button,
                    desc = "Refreshes the list of the businesses.",
                    func = function()
                        Utils.FillDynamicTables()
                        Parser.ParseTables(eTable)
                        Script.ReAssign()
                        SilentLogger.LogInfo("[Refresh (Misc)] 产业列表已刷新 ツ")
                    end
                }
            },

            Garment = {
                Teleport = {
                    Entrance = {
                        hash = J("SN_Garment_Entrance"),
                        name = "Teleport to Entrance",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Garment Factory's entrance.",
                        func = function()
                            GTA.TeleportToBlip(eTable.BlipSprites.Garment)
                            SilentLogger.LogInfo("[Teleport to Entrance (Garment Factory)] 你已被传送至入口 ツ")
                        end
                    },

                    Computer = {
                        hash = J("SN_Garment_Computer"),
                        name = "Teleport to Computer",
                        type = eFeatureType.Button,
                        desc = "Teleports you to the Garment Factory's computer.",
                        func = function()
                            GTA.TeleportXYZ(U(eTable.Teleports.Garment))
                            SilentLogger.LogInfo("[Open Computer (Garment Factory)] 电脑界面已打开 ツ")
                        end
                    }
                },

                Unbrick = {
                    hash = J("SN_Misc_GarmentUnbrick"),
                    name = "Unbrick Computer",
                    type = eFeatureType.Button,
                    desc = "Unbricks your Garment Factory computer after using features like «Unlock All Awards».",
                    func = function()
                        eStat.MPX_HACKER24_GEN_BS:Set(-24607)
                        SilentLogger.LogInfo("[Unbrick Computer (Misc)] 服装工厂电脑已解锁 ツ")
                    end
                }
            }
        }
    },

    Money = {
        Casino = {
            LuckyWheel = {
                Select = {
                    hash = J("SN_Casino_LuckyWheelSelect"),
                    name = "Prize",
                    type = eFeatureType.Combo,
                    desc = "Select the desired prize.",
                    list = eTable.World.Casino.Prizes,
                    func = function(ftr)
                        local list  = eTable.World.Casino.Prizes
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Prize (Casino)] 已选择奖品：%s ツ", list:GetName(index)))
                    end
                },

                Give = {
                    hash = J("SN_Casino_LuckyWheelGive"),
                    name = "Give Prize",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: use once per day.\nGives the selected prize instantly.",
                    func = function(prize)
                        eLocal.World.Casino.LuckyWheel.WinState:Set(prize)
                        eLocal.World.Casino.LuckyWheel.PrizeState:Set(11)
                        SilentLogger.LogInfo("[Prize (Casino)] 奖品已发放 ツ")
                    end
                }
            },

            Slots = {
                Win = {
                    hash = J("SN_Casino_SlotsWin"),
                    name = "Rig Slots",
                    type = eFeatureType.Button,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nForces the slots to give you the jackpot.",
                    func = function()
                        local randomResultTable = eLocal.World.Casino.Slots.RandomResultTable.vLocal

                        for i = 3, 196 do
                            if i ~= 67 and i ~= 132 then
                                ScriptLocal.SetInt(eScript.World.Casino.Slots.hash, randomResultTable + i, 6)
                            end
                        end

                        SilentLogger.LogInfo("[Rig Slots (Casino)] 老虎机已篡改（强制中头奖） ツ")
                    end
                },

                Lose = {
                    hash = J("SN_Casino_SlotsLoose"),
                    name = "Lose Slots",
                    type = eFeatureType.Button,
                    desc = "Forces the slots to always lose.",
                    func = function()
                        local randomResultTable = eLocal.World.Casino.Slots.RandomResultTable.vLocal

                        for i = 3, 196 do
                            if i ~= 67 and i ~= 132 then
                                ScriptLocal.SetInt(eScript.World.Casino.Slots.hash, randomResultTable + i, 0)
                            end
                        end

                        SilentLogger.LogInfo("[Lose Slots (Casino)] 老虎机已篡改（强制输） ツ")
                    end
                }
            },

            Roulette = {
                Land13 = {
                    hash = J("SN_Casino_RouletteLand13"),
                    name = "Land On Black 13",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: might be unsafe, if overused.\nForces the ball to land on Black 13. Use after there is no time for betting.",
                    func = function()
                        GTA.ForceScriptHost(eScript.World.Casino.Roulette)
                        local masterTable   = eLocal.World.Casino.Roulette.MasterTable.vLocal
                        local outcomesTable = eLocal.World.Casino.Roulette.OutcomesTable.vLocal
                        local ballTable     = eLocal.World.Casino.Roulette.BallTable.vLocal

                        for i = 0, 5 do
                            ScriptLocal.SetInt(eScript.World.Casino.Roulette.hash, masterTable + outcomesTable + ballTable + i, 13)
                        end

                        SilentLogger.LogInfo("[Land On Black 13 (Casino)] 小球已落至黑13 ツ")
                    end
                },

                Land16 = {
                    hash = J("SN_Casino_RouletteLand16"),
                    name = "Land On Red 16",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: might be unsafe, if overused.\nForces the ball to land on Red 16. Use after there is no time for betting.",
                    func = function()
                        GTA.ForceScriptHost(eScript.World.Casino.Roulette)
                        local masterTable   = eLocal.World.Casino.Roulette.MasterTable.vLocal
                        local outcomesTable = eLocal.World.Casino.Roulette.OutcomesTable.vLocal
                        local ballTable     = eLocal.World.Casino.Roulette.BallTable.vLocal

                        for i = 0, 5 do
                            ScriptLocal.SetInt(eScript.World.Casino.Roulette.hash, masterTable + outcomesTable + ballTable + i, 16)
                        end

                        SilentLogger.LogInfo("[Land On Red 16 (Casino)] 小球已落至红16 ツ")
                    end
                }
            },

            Blackjack = {
                Card = {
                    hash = J("SN_Casino_BlackjackCard"),
                    name = "Dealer's Face Down Card",
                    type = eFeatureType.InputText,
                    desc = "Shows the dealer's face down card."
                },

                Reveal = {
                    hash = J("SN_Casino_BlackjackReveal"),
                    name = "Reveal Card",
                    type = eFeatureType.Button,
                    desc = "Reveals the dealer's face down card. Works better in solo session.",
                    func = function()
                        SilentLogger.LogInfo("[Reveal Card (Casino)] 庄家底牌已显示 ツ")
                    end
                },

                Trick = {
                    hash = J("SN_Casino_BlackjackTrick"),
                    name = "Trick The Dealer",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: might be unsafe, if overused.\nForces the dealer's hand to lose. Also, reveals the dealer's cards. Works better in solo session.",
                    func = function()
                        GTA.ForceScriptHost(eScript.World.Casino.Blackjack)
                        if eLocal.World.Casino.Blackjack.CurrentTable:Get() ~= -1 then
                            eLocal.World.Casino.Blackjack.Dealer.FirstCard:Set(11)
                            eLocal.World.Casino.Blackjack.Dealer.SecondCard:Set(12)
                            eLocal.World.Casino.Blackjack.Dealer.ThirdCard:Set(13)
                            eLocal.World.Casino.Blackjack.VisibleCards:Set(3)
                        end
                        SilentLogger.LogInfo("[Trick The Dealer (Casino)] 庄家手牌已被篡改（强制输） ツ")
                    end
                }
            },

            Poker = {
                MyCards = {
                    hash = J("SN_Casino_PokerMyCards"),
                    name = "Your Cards",
                    type = eFeatureType.InputText,
                    desc = "Shows your cards."
                },

                Cards = {
                    hash = J("SN_Casino_PokerCards"),
                    name = "Dealer's Cards",
                    type = eFeatureType.InputText,
                    desc = "Shows the dealer's cards."
                },

                Reveal = {
                    hash = J("SN_Casino_PokerReveal"),
                    name = "Reveal Cards",
                    type = eFeatureType.Button,
                    desc = "Reveals your and the dealer's cards. Works better in solo session.",
                    func = function()
                        SilentLogger.LogInfo("[Reveal Cards (Casino)] 你和庄家的所有牌已显示 ツ")
                    end
                },

                Give = {
                    hash = J("SN_Casino_PokerGive"),
                    name = "Give Straight Flush",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: might be unsafe, if overused.\nForces your hand to win. Also, reveals your and the dealer's cards. Use during the animation of your character getting at a table. Works better in solo session.",
                    func = function()
                        GTA.ForceScriptHost(eScript.World.Casino.Poker)
                        Helper.SetPokerCards(0, 50, 51, 52)
                        SilentLogger.LogInfo("[Give Straight Flush (Casino)] 你的手牌已获得同花顺（强制赢） ツ")
                    end
                },

                Trick = {
                    hash = J("SN_Casino_PokerTrick"),
                    name = "Trick The Dealer",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: might be unsafe, if overused.\nForces the dealer's hand to lose. Also, reveals your and the dealer's cards. Use during the animation of your character getting at a table. Works better in solo session.",
                    func = function()
                        GTA.ForceScriptHost(eScript.World.Casino.Poker)
                        if eLocal.World.Casino.Poker.CurrentTable:Get() ~= -1 then
                            local id = Helper.GetPokerPlayersCount() + 1
                            Helper.SetPokerCards(id, 2, 17, 32)
                        end
                        SilentLogger.LogInfo("[Trick The Dealer (Casino)] 庄家手牌已被篡改（强制输） ツ")
                    end
                }
            },

                    Misc = {
                Bypass = {
                    hash = J("SN_Casino_Bypass"),
                    name = "Bypass Casino Limits",
                    type = eFeatureType.Toggle,
                    desc = "ATTENTION: might be unsafe, if used for more chips.\nBypasses the casino limits.",
                    func = function(ftr)
                        if ftr:IsToggled() then
                            eStat.MPPLY_CASINO_CHIPS_WON_GD:Set(0)
                            eStat.MPPLY_CASINO_CHIPS_WONTIM:Set(0)
                            eStat.MPPLY_CASINO_GMBLNG_GD:Set(0)
                            eStat.MPPLY_CASINO_BAN_TIME:Set(0)
                            eStat.MPPLY_CASINO_CHIPS_PURTIM:Set(0)
                            eStat.MPPLY_CASINO_CHIPS_PUR_GD:Set(0)

                            if not loggedCasinoLimits then
                                SilentLogger.LogInfo("[Bypass Casino Limits (Casino)] 赌场限制已突破 ツ")
                                loggedCasinoLimits = true
                            end
                        else
                            eTunable.World.Casino.Chips.Limit.Acquire:Reset()
                            eTunable.World.Casino.Chips.Limit.AcquirePenthouse:Reset()
                            eTunable.World.Casino.Chips.Limit.Trade:Reset()
                            SilentLogger.LogInfo("[Bypass Casino Limits (Casino)] 赌场限制已重置 ツ")
                            loggedCasinoLimits = false
                        end
                    end
                },

                Limit = {
                    Select = {
                        hash = J("SN_Casino_Select"),
                        name = "Chips Limit",
                        type = eFeatureType.InputInt,
                        desc = "Select the desired chips limit.",
                        defv = 0,
                        lims = { 0, INT32_MAX },
                        step = 1000000,
                        func = function(ftr)
                            SilentLogger.LogInfo("[Chips Limit (Casino)] 筹码上限已更改。别忘了应用更改 ツ")
                        end
                    },

                    Acquire = {
                        hash = J("SN_Casino_Acquire"),
                        name = "Apply Acquire Limit",
                        type = eFeatureType.Button,
                        desc = "Applies the selected acquire chips limit.",
                        func = function(limit)
                            eTunable.World.Casino.Chips.Limit.Acquire:Set(limit)
                            eTunable.World.Casino.Chips.Limit.AcquirePenthouse:Set(limit)
                            SilentLogger.LogInfo("[Apply Acquire Limit (Casino)] 获取筹码上限已应用 ツ")
                        end
                    },

                    Trade = {
                        hash = J("SN_Casino_Trade"),
                        name = "Apply Trade In Limit",
                        type = eFeatureType.Button,
                        desc = "ATTENTION: might be unsafe, no bans reported.\nApplies the selected trade in chips limit.",
                        func = function(limit)
                            eTunable.World.Casino.Chips.Limit.Trade:Set(limit)
                            SilentLogger.LogInfo("[Apply Trade In Limit (Casino)] 兑换筹码上限已应用 ツ")
                        end
                    }
                }
            }
        },

        EasyMoney = {
            Acknowledge = {
                hash = J("SN_EasyMoney_IAcknowledge"),
                name = "I Acknowledge",
                type = eFeatureType.Toggle,
                desc = "Allows using «Easy Money» features.",
                func = function(ftr)
                    CONFIG.easy_money.acknowledge = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedAcknowledgment then
                        loggedAcknowledgment = false
                        return
                    end

                    SilentLogger.LogInfo(F("[I Acknowledge (Easy Money)] 快速赚钱功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            Instant = {
                Give30m = {
                    hash = J("SN_EasyMoney_30m"),
                    name = "Give 30mil",
                    type = eFeatureType.Button,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nGives 30mil dollars in a few seconds. Has a cooldown.",
                    func = function()
                        if not CONFIG.easy_money.acknowledge then
                            SilentLogger.LogError("[Give 30mil (Easy Money)] 你必须先确认风险 ツ")
                            return
                        end

                        GTA.TriggerTransaction(0xA174F633)
                        Script.Yield(3000)
                        GTA.TriggerTransaction(0xED97AFC1)
                        Script.Yield(3000)
                        GTA.TriggerTransaction(0x176D9D54)
                        Script.Yield(3000)
                        GTA.TriggerTransaction(0x4B6A869C)
                        Script.Yield(3000)
                        GTA.TriggerTransaction(0x921FCF3C)
                        Script.Yield(3000)
                        GTA.TriggerTransaction(0x314FB8B0)
                        SilentLogger.LogInfo("[Give 30mil (Easy Money)] 3000万美元已发放 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                }
            },

            Freeroam = {
                _5k = {
                    hash = J("SN_EasyMoney_5k"),
                    name = "5k Loop",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nToggles the 5k chips loop.",
                    func = function(ftr, delay)
                        if not CONFIG.easy_money.acknowledge then
                            if ftr:IsToggled() then
                                SilentLogger.LogError("[5k Loop (Easy Money)] 你必须先确认风险 ツ")
                            end

                            ftr:Toggle(false)
                            return
                        end

                        if ftr:IsToggled() then
                            eGlobal.World.Casino.Chips.Bonus:Set(true)

                            if not logged5kLoop then
                                SilentLogger.LogInfo("[5k Loop (Easy Money)] 5000筹码循环已启用 ツ", eToastPos.BOTTOM_RIGHT)
                                logged5kLoop = true
                            end

                            Script.Yield(math.floor(delay * 1000))
                        else
                            SilentLogger.LogInfo("[5k Loop (Easy Money)] 5000筹码循环已禁用 ツ", eToastPos.BOTTOM_RIGHT)
                            logged5kLoop = false
                        end
                    end
                },

                _50k = {
                    hash = J("SN_EasyMoney_50k"),
                    name = "50k Loop",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nToggles the 50k dollars loop.",
                    func = function(ftr, delay)
                        if not CONFIG.easy_money.acknowledge then
                            if ftr:IsToggled() then
                                SilentLogger.LogError("[50k Loop (Easy Money)] 你必须先确认风险 ツ")
                            end

                            ftr:Toggle(false)
                            return
                        end

                        if ftr:IsToggled() then
                            GTA.TriggerTransaction(0x610F9AB4)

                            if not logged50kLoop then
                                SilentLogger.LogInfo("[50k Loop (Easy Money)] 5万美元循环已启用 ツ", eToastPos.BOTTOM_RIGHT)
                                logged50kLoop = true
                            end

                            Script.Yield(math.floor(delay * 1000))
                        else
                            SilentLogger.LogInfo("[50k Loop (Easy Money)] 5万美元循环已禁用 ツ", eToastPos.BOTTOM_RIGHT)
                            logged50kLoop = false
                        end
                    end
                },

                _100k = {
                    hash = J("SN_EasyMoney_100k"),
                    name = "100k Loop",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nToggles the 100k dollars loop.",
                    func = function(ftr, delay)
                        if not CONFIG.easy_money.acknowledge then
                            if ftr:IsToggled() then
                                SilentLogger.LogError("[100k Loop (Easy Money)] 你必须先确认风险 ツ")
                            end

                            ftr:Toggle(false)
                            return
                        end

                        if ftr:IsToggled() then
                            GTA.TriggerTransaction(J("SERVICE_EARN_AMBIENT_JOB_AMMUNATION_DELIVERY"))

                            if not logged100kLoop then
                                SilentLogger.LogInfo("[100k Loop (Easy Money)] 10万美元循环已启用 ツ", eToastPos.BOTTOM_RIGHT)
                                logged100kLoop = true
                            end

                            Script.Yield(math.floor(delay * 1000))
                        else
                            SilentLogger.LogInfo("[100k Loop (Easy Money)] 10万美元循环已禁用 ツ", eToastPos.BOTTOM_RIGHT)
                            logged100kLoop = false
                        end
                    end
                },

                _180k = {
                    hash = J("SN_EasyMoney_180k"),
                    name = "180k Loop",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nToggles the 180k dollars loop. Has a cooldown.",
                    func = function(ftr, delay)
                        if not CONFIG.easy_money.acknowledge then
                            if ftr:IsToggled() then
                                SilentLogger.LogError("[180k Loop (Easy Money)] 你必须先确认风险 ツ")
                            end

                            ftr:Toggle(false)
                            return
                        end

                        if ftr:IsToggled() then
                            GTA.TriggerTransaction(0x615762F1)

                            if not logged180kLoop then
                                SilentLogger.LogInfo("[180k Loop (Easy Money)] 18万美元循环已启用 ツ", eToastPos.BOTTOM_RIGHT)
                                logged180kLoop = true
                            end

                            Script.Yield(math.floor(delay * 1000))
                        else
                            SilentLogger.LogInfo("[180k Loop (Easy Money)] 18万美元循环已禁用 ツ", eToastPos.BOTTOM_RIGHT)
                            logged180kLoop = false
                        end
                    end
                },

                _680k = {
                    hash = J("SN_EasyMoney_680k"),
                    name = "680k Loop",
                    type = eFeatureType.Toggle,
                    desc = "CAUTION: might be unsafe, bans reported in the past.\nToggles the 680k dollars loop. Has a cooldown.",
                    func = function(ftr, delay)
                        if not CONFIG.easy_money.acknowledge then
                            if ftr:IsToggled() then
                                SilentLogger.LogError("[680k Loop (Easy Money)] 你必须先确认风险 ツ")
                            end

                            ftr:Toggle(false)
                            return
                        end

                        if ftr:IsToggled() then
                            GTA.TriggerTransaction(J("SERVICE_EARN_BETTING"))

                            if not logged680kLoop then
                                SilentLogger.LogInfo("[680k Loop (Easy Money)] 68万美元循环已启用 ツ", eToastPos.BOTTOM_RIGHT)
                                logged680kLoop = true
                            end

                            Script.Yield(math.floor(delay * 1000))
                        else
                            SilentLogger.LogInfo("[680k Loop (Easy Money)] 68万美元循环已禁用 ツ", eToastPos.BOTTOM_RIGHT)
                            logged680kLoop = false
                        end
                    end
                }
            },

            Property = {
                _300k = {
                    hash = J("SN_EasyMoney_300k"),
                    name = "300k Loop",
                    type = eFeatureType.Toggle,
                    desc = F("CAUTION: might be unsafe, if overused.\nToggles the 300k dollars loop.%s Has a cooldown.", (GTA_EDITION == "LE") and " Use inside your Nightclub." or ""),
                    func = function(ftr, delay)
                        if not CONFIG.easy_money.acknowledge then
                            if ftr:IsToggled() then
                                SilentLogger.LogError("[300k Loop (Easy Money)] 你必须先确认风险 ツ")
                            end

                            ftr:Toggle(false)
                            return
                        end

                        if ftr:IsToggled() then
                            local top5      = eGlobal.Business.Nightclub.Safe.Income.Top5.global
                            local top100    = eGlobal.Business.Nightclub.Safe.Income.Top100.global
                            local safeValue = eGlobal.Business.Nightclub.Safe.Value:Get()
                            local maxValue  = 300000

                            eTunable.Business.Nightclub.Safe.MaxCapacity:Set(maxValue)

                            for i = top5, top100 do
                                ScriptGlobal.SetInt(i, maxValue)
                            end

                            if safeValue <= maxValue and safeValue ~= 0 then
                                if CONFIG.easy_money.allow_300k_loop and GTA_EDITION == "EE" then
                                    eGlobal.Business.Nightclub.Safe.Collect:Set(true)
                                else
                                    eLocal.Business.Nightclub.Safe.Type:Set(3)
                                    eLocal.Business.Nightclub.Safe.Collect:Set(1)
                                end
                            elseif safeValue == 0 then
                                eStat.MPX_CLUB_PAY_TIME_LEFT:Set(-1)

                                if CONFIG.easy_money.autodeposit then
                                    local charSlot = eStat.MPPLY_LAST_MP_CHAR:Get()
                                    local amount   = eNative.MONEY.NETWORK_GET_VC_WALLET_BALANCE(charSlot)

                                    if amount > 0 then
                                        eNative.NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(charSlot, amount)
                                    end
                                end
                            end

                            if not logged300kLoop then
                                SilentLogger.LogInfo("[300k Loop (Easy Money)] 30万美元循环已启用 ツ", eToastPos.BOTTOM_RIGHT)
                                logged300kLoop = true
                            end

                            Script.Yield(math.floor(delay * 1000))
                        else
                            SilentLogger.LogInfo("[300k Loop (Easy Money)] 30万美元循环已禁用 ツ", eToastPos.BOTTOM_RIGHT)
                            logged300kLoop = false
                        end
                    end
                }
            }
        },

        Misc = {
            Edit = {
                DepositAll = {
                    hash = J("SN_Misc_EditDepositAll"),
                    name = "Deposit All",
                    type = eFeatureType.Button,
                    desc = "Deposits all money to your bank.",
                    func = function()
                        local charSlot    = eStat.MPPLY_LAST_MP_CHAR:Get()
                        local walletMoney = eNative.MONEY.NETWORK_GET_VC_WALLET_BALANCE(charSlot)
                        eNative.NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(charSlot, walletMoney)
                        SilentLogger.LogInfo("[Deposit All (Misc)] 所有资金已存入银行 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                },

                WithdrawAll = {
                    hash = J("SN_Misc_EditWithdrawAll"),
                    name = "Withdraw All",
                    type = eFeatureType.Button,
                    desc = "Withdraws all money from your bank.",
                    func = function()
                        local charSlot  = eStat.MPPLY_LAST_MP_CHAR:Get()
                        local bankMoney = eNative.MONEY.NETWORK_GET_VC_BANK_BALANCE()
                        eNative.NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(charSlot, bankMoney)
                        SilentLogger.LogInfo("[Withdraw All (Misc)] 所有资金已从银行取出 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                },

                Select = {
                    hash = J("SN_Misc_EditSelect"),
                    name = "Money Amount",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired money amount.",
                    defv = 0,
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Money Amount (Misc)] 金额已更改。别忘了应用更改 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                },

                Deposit = {
                    hash = J("SN_Misc_EditDeposit"),
                    name = "Deposit",
                    type = eFeatureType.Button,
                    desc = "Deposits the selected money amount to your bank.",
                    func = function(amount)
                        if amount == 0 then
                            SilentLogger.LogError("[Deposit (Misc)] 你必须先选择一个金额 ツ")
                            return
                        end

                        local charSlot    = eStat.MPPLY_LAST_MP_CHAR:Get()
                        local walletMoney = eNative.MONEY.NETWORK_GET_VC_WALLET_BALANCE(charSlot)
                        local amount      = (amount > walletMoney) and walletMoney or amount
                        eNative.NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(charSlot, amount)
                        SilentLogger.LogInfo("[Deposit (Misc)] 该金额已存入银行 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                },

                Withdraw = {
                    hash = J("SN_Misc_EditWithdraw"),
                    name = "Withdraw",
                    type = eFeatureType.Button,
                    desc = "Withdraws the selected money amount from your bank.",
                    func = function(amount)
                        if amount == 0 then
                            SilentLogger.LogError("[Withdraw (Misc)] 你必须先选择一个金额 ツ")
                            return
                        end

                        local charSlot  = eStat.MPPLY_LAST_MP_CHAR:Get()
                        local bankMoney = eNative.MONEY.NETWORK_GET_VC_BANK_BALANCE()
                        local amount    = (amount > bankMoney) and bankMoney or amount
                        eNative.NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(charSlot, amount)
                        SilentLogger.LogInfo("[Withdraw (Misc)] 该金额已从银行取出 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                },

                Remove = {
                    hash = J("SN_Misc_Remove"),
                    name = "Remove",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: cannot be undone.\nRemoves the selected money amount from your character.",
                    func = function(amount)
                        if amount == 0 then
                            SilentLogger.LogError("[Remove (Misc)] 你必须先选择一个金额 ツ")
                            return
                        end

                        local charSlot    = eStat.MPPLY_LAST_MP_CHAR:Get()
                        local bankMoney   = eNative.MONEY.NETWORK_GET_VC_BANK_BALANCE()
                        local walletMoney = eNative.MONEY.NETWORK_GET_VC_WALLET_BALANCE(charSlot)
                        local amount      = (amount > bankMoney + walletMoney) and bankMoney + walletMoney or amount
                        eGlobal.Player.Cash.Remove:Set(amount)
                        SilentLogger.LogInfo("[Remove (Misc)] 该金额已从角色账户移除 ツ", eToastPos.BOTTOM_RIGHT)
                    end
                }
            },

                Story = {
                Select = {
                    hash = J("SN_Misc_StorySelect"),
                    name = "Money Amount",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired money amount.",
                    defv = eStat.SP0_TOTAL_CASH:Get(),
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Money Amount (Misc)] 金额已更改。别忘了应用更改 ツ")
                    end
                },

                Character = {
                    hash = J("SN_Misc_StoryCharacter"),
                    name = "Character",
                    type = eFeatureType.Combo,
                    desc = "Select the desired story character.",
                    list = eTable.Story.Characters,
                    func = function(ftr)
                        local list  = eTable.Story.Characters
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Character (Misc)] 已选择剧情角色：%s ツ", list:GetName(index)))
                    end
                },

                Apply = {
                    hash = J("SN_Misc_StoryApply"),
                    name = "Apply Money Amount",
                    type = eFeatureType.Button,
                    desc = "Applies the selected money amount to the selected story character.",
                    func = function(charIndex, amount)
                        eStat[F("SP%d_TOTAL_CASH", charIndex)]:Set(amount)
                        SilentLogger.LogInfo(F("[Apply Money Amount (Misc)] 金额已应用 ツ"), eToastPos.BOTTOM_RIGHT)
                    end
                }
            },

            Stats = {
                Select = {
                    hash = J("SN_Misc_StatsSelect"),
                    name = "Money Amount",
                    type = eFeatureType.InputInt,
                    desc = "Select the desired money amount.",
                    defv = 0,
                    lims = { 0, INT32_MAX },
                    step = 1000000,
                    func = function(ftr)
                        SilentLogger.LogInfo("[Money Amount (Misc)] 金额已更改。别忘了应用更改 ツ")
                    end
                },

                Earned = {
                    hash = J("SN_Misc_StatsEarned"),
                    name = "Earned",
                    type = eFeatureType.Combo,
                    desc = "Select the desired «Earned» stat.",
                    list = eTable.Cash.Stats.Earneds,
                    func = function(ftr)
                        local list  = eTable.Cash.Stats.Earneds
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Earned (Misc)] 已选择收入统计项：%s ツ", list:GetName(index)))
                    end
                },

                Spent = {
                    hash = J("SN_Misc_StatsSpent"),
                    name = "Spent",
                    type = eFeatureType.Combo,
                    desc = "Select the desired «Spent» stat.",
                    list = eTable.Cash.Stats.Spents,
                    func = function(ftr)
                        local list  = eTable.Cash.Stats.Spents
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Spent (Misc)] 已选择支出统计项：%s ツ", list:GetName(index)))
                    end
                },

                Apply = {
                    hash = J("SN_Misc_StatsApply"),
                    name = "Apply Money Amount",
                    type = eFeatureType.Button,
                    desc = "Applies the selected money amount to the selected stat.",
                    func = function(earnedStat, spentStat, amount)
                        if earnedStat ~= 0 then
                            earnedStat:Set(amount)
                            SilentLogger.LogInfo("[Apply Money Amount (Misc)] 收入统计项已修改 ツ")
                            return
                        end
                        if spentStat ~= 0 then
                            spentStat:Set(amount)
                            SilentLogger.LogInfo("[Apply Money Amount (Misc)] 支出统计项已修改 ツ")
                            return
                        end
                        SilentLogger.LogError("[Apply Money Amount (Misc)] 你必须先选择一个统计项 ツ")
                    end
                }
            }
        }
    },

    Dev = {
        Editor = {
            Globals = {
                Type = {
                    hash = J("SN_Editor_GlobalsType"),
                    name = "Type",
                    type = eFeatureType.Combo,
                    desc = "Select the desired global type.",
                    list = eTable.Editor.Globals.Types,
                    func = function(ftr)
                        local list  = eTable.Editor.Globals.Types
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Type (Globals)] 已选择全局变量类型：%s ツ", list:GetName(index)))
                    end
                },

                Global = {
                    hash = J("SN_Editor_GlobalsGlobal"),
                    name = "262145 + 9415",
                    type = eFeatureType.InputText,
                    desc = "Input your global here."
                },

                Value = {
                    hash = J("SN_Editor_GlobalsValue"),
                    name = "100",
                    type = eFeatureType.InputText,
                    desc = "Input your value here."
                },

                Read = {
                    hash = J("SN_Editor_GlobalsRead"),
                    name = "Read",
                    type = eFeatureType.Button,
                    desc = "Reads the entered global value.",
                    func = function()
                        SilentLogger.LogInfo("[Read (Dev Tool)] 已从全局变量读取值 ツ")
                    end
                },

                Write = {
                    hash = J("SN_Editor_GlobalsWrite"),
                    name = "Write",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: for advanced users.\nWrites the selected value to the entered global.",
                    func = function(type, global, value)
                        local SetValue = {
                            ["int"]   = ScriptGlobal.SetInt,
                            ["float"] = ScriptGlobal.SetFloat,
                            ["bool"]  = ScriptGlobal.SetBool
                        }

                        SetValue[type](global, value)
                        SilentLogger.LogInfo("[Write (Dev Tool)] 已将值写入全局变量 ツ")
                    end
                },

                Revert = {
                    hash = J("SN_Editor_GlobalsRevert"),
                    name = "Revert",
                    type = eFeatureType.Button,
                    desc = "Reverts the previous value you've written to the entered global.",
                    func = function(type, global)
                        local SetValue = {
                            ["int"]   = ScriptGlobal.SetInt,
                            ["float"] = ScriptGlobal.SetFloat,
                            ["bool"]  = ScriptGlobal.SetBool
                        }

                        if TEMP_GLOBAL ~= "TEMP" then
                            SetValue[type](global, TEMP_GLOBAL)
                            TEMP_GLOBAL = "TEMP"
                        end

                        SilentLogger.LogInfo("[Revert (Dev Tool)] 已还原全局变量值 ツ")
                    end
                }
            },

            Locals = {
                Type = {
                    hash = J("SN_Editor_LocalsType"),
                    name = "Type",
                    type = eFeatureType.Combo,
                    desc = "Select the desired local type.",
                    list = eTable.Editor.Locals.Types,
                    func = function(ftr)
                        local list  = eTable.Editor.Locals.Types
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Type (Locals)] 已选择本地变量类型：%s ツ", list:GetName(index)))
                    end
                },

                Script = {
                    hash = J("SN_Editor_LocalsScript"),
                    name = "fm_mission_controller",
                    type = eFeatureType.InputText,
                    desc = "Input your script here."
                },

                Local = {
                    hash = J("SN_Editor_LocalsLocal"),
                    name = "10291",
                    type = eFeatureType.InputText,
                    desc = "Input your local here."
                },

                Value = {
                    hash = J("SN_Editor_LocalsValue"),
                    name = "4",
                    type = eFeatureType.InputText,
                    desc = "Input your value here."
                },

                Read = {
                    hash = J("SN_Editor_LocalsRead"),
                    name = "Read",
                    type = eFeatureType.Button,
                    desc = "Reads the entered local value.",
                    func = function()
                        SilentLogger.LogInfo("[Read (Dev Tool)] 已从本地变量读取值 ツ")
                    end
                },

                Write = {
                    hash = J("SN_Editor_LocalsWrite"),
                    name = "Write",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: for advanced users.\nWrites the selected value to the entered local.",
                    func = function(type, hash, vLocal, value)
                        local SetValue = {
                            ["int"]   = ScriptLocal.SetInt,
                            ["float"] = ScriptLocal.SetFloat
                        }

                        SetValue[type](hash, vLocal, value)
                        SilentLogger.LogInfo("[Write (Dev Tool)] 已将值写入本地变量 ツ")
                    end
                },

                Revert = {
                    hash = J("SN_Editor_LocalsRevert"),
                    name = "Revert",
                    type = eFeatureType.Button,
                    desc = "Reverts the previous value you've written to the entered local.",
                    func = function(type, hash, vLocal)
                        local SetValue = {
                            ["int"]   = ScriptLocal.SetInt,
                            ["float"] = ScriptLocal.SetFloat
                        }

                        if TEMP_LOCAL ~= "TEMP" then
                            SetValue[type](hash, vLocal, TEMP_LOCAL)
                            TEMP_LOCAL = "TEMP"
                        end

                        SilentLogger.LogInfo("[Revert (Dev Tool)] 已还原本地变量值 ツ")
                    end
                }
            },

            Stats = {
                From = {
                    hash = J("SN_Editor_StatsFrom"),
                    name = "From File",
                    type = eFeatureType.Toggle,
                    desc = "Allows to write the stats from the file.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[From File (Dev Tool)] 从文件读取统计项功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                    end
                },

                Type = {
                    hash = J("SN_Editor_StatsType"),
                    name = "Type",
                    type = eFeatureType.Combo,
                    desc = "Select the desired stat type.",
                    list = eTable.Editor.Stats.Types,
                    func = function(ftr)
                        local list  = eTable.Editor.Stats.Types
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Type (Stats)] 已选择统计项类型：%s ツ", list:GetName(index)))
                    end
                },

                Stat = {
                    hash = J("SN_Editor_StatsStat"),
                    name = "MPX_KILLS",
                    type = eFeatureType.InputText,
                    desc = "Input your stat here."
                },

                Value = {
                    hash = J("SN_Editor_StatsValue"),
                    name = "7777",
                    type = eFeatureType.InputText,
                    desc = "Input your value here."
                },

                Read = {
                    hash = J("SN_Editor_StatsRead"),
                    name = "Read",
                    type = eFeatureType.Button,
                    desc = "Reads the entered stat value.",
                    func = function()
                        SilentLogger.LogInfo("[Read (Dev Tool)] 已从统计项读取值 ツ")
                    end
                },

                Write = {
                    hash = J("SN_Editor_StatsWrite"),
                    name = "Write",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: for advanced users.\nWrites the selected value to the entered stat.",
                    func = function(type, hash, value)
                        local SetValue = {
                            ["int"]    = Stats.SetInt,
                            ["float"]  = Stats.SetFloat,
                            ["bool"]   = Stats.SetBool,
                            ["string"] = Stats.SetString
                        }

                        if type == "int" then
                            if math.abs(value) <= INT32_MAX then
                                SetValue[type](hash, value)
                            else
                                local loops     = math.floor(math.abs(value) / INT32_MAX)
                                local remainder = math.abs(value) - (loops * INT32_MAX)
                                local sign      = (value < 0) and -1 or 1

                                for i = 1, loops do
                                    eNative.STATS.STAT_INCREMENT(hash, sign * INT32_MAX + .0)
                                end

                                eNative.STATS.STAT_INCREMENT(hash, sign * remainder + .0)
                            end
                        else
                            SetValue[type](hash, value)
                        end

                        SilentLogger.LogInfo("[Write (Dev Tool)] 已将值写入统计项 ツ")
                    end
                },

                Revert = {
                    hash = J("SN_Editor_StatsRevert"),
                    name = "Revert",
                    type = eFeatureType.Button,
                    desc = "Reverts the previous value you've written to the entered stat.",
                    func = function(type, hash)
                        local SetValue = {
                            ["int"]    = Stats.SetInt,
                            ["float"]  = Stats.SetFloat,
                            ["bool"]   = Stats.SetBool,
                            ["string"] = Stats.SetString
                        }

                        if TEMP_STAT ~= "TEMP" then
                            SetValue[type](hash, TEMP_STAT)
                            TEMP_STAT = "TEMP"
                        end

                        SilentLogger.LogInfo("[Revert (Dev Tool)] 已还原统计项值 ツ")
                    end
                },

                File = {
                    hash = J("SN_Editor_StatsFile"),
                    name = "File",
                    type = eFeatureType.Combo,
                    desc = "Select the desired stat file.",
                    list = eTable.Editor.Stats.Files,
                    func = function(ftr)
                        local list  = eTable.Editor.Stats.Files
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[File (Dev Tool)] 已选择统计文件：%s ツ", (list:GetName(index) == "") and "空文件" or list:GetName(index)))
                    end
                },

                WriteAll = {
                    hash = J("SN_Editor_StatsWriteAll"),
                    name = "Write",
                    type = eFeatureType.Button,
                    desc = "Writes all the stats from the selected file.",
                    func = function(file)
                        local path = F("%s\\%s.json", STATS_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            local json = Json.DecodeFromFile(path)

                            for stat, value in pairs(json.stats) do
                                if stat:sub(1, 3) == "MPX" then
                                    stat = stat:gsub("MPX", F("MP%d", eStat.MPPLY_LAST_MP_CHAR:Get()))
                                end

                                if type(value) == "number" then
                                    if math.type(value) == "integer" then
                                        if math.abs(value) <= INT32_MAX then
                                            Stats.SetInt(J(stat), value)
                                        else
                                            local loops     = math.floor(math.abs(value) / INT32_MAX)
                                            local remainder = math.abs(value) - (loops * INT32_MAX)
                                            local sign      = (value < 0) and -1 or 1

                                            for i = 1, loops do
                                                eNative.STATS.STAT_INCREMENT(J(stat), sign * INT32_MAX + .0)
                                            end

                                            eNative.STATS.STAT_INCREMENT(J(stat), sign * remainder + .0)
                                        end
                                    else
                                        Stats.SetFloat(J(stat), value)
                                    end
                                elseif type(value) == "boolean" then
                                    Stats.SetBool(J(stat), value)
                                else
                                    Stats.SetString(J(stat), value)
                                end
                            end

                            SilentLogger.LogInfo(F("[Write All (Dev Tool)] 已写入«%s»文件中的所有统计项 ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Write All (Dev Tool)] 统计文件«%s»不存在 ツ", (file == "") and "空文件" or file))
                    end
                },

                Remove = {
                    hash = J("SN_Editor_StatsRemove"),
                    name = "Remove",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: cannot be undone.\nRemoves the selected stats file.",
                    func = function(file)
                        local path = F("%s\\%s.json", STATS_DIR, file)

                        if FileMgr.DoesFileExist(path) then
                            FileMgr.DeleteFile(path)
                            Helper.RefreshFiles()
                            SilentLogger.LogInfo(F("[Remove (Dev Tool)] 已删除统计文件«%s» ツ", file))
                            return
                        end

                        SilentLogger.LogError(F("[Remove (Dev Tool)] 统计文件«%s»不存在 ツ", (file == "") and "空文件" or file))
                    end
                },

                Refresh = {
                    hash = J("SN_Editor_StatsRefresh"),
                    name = "Refresh",
                    type = eFeatureType.Button,
                    desc = "Refreshes the list of stats files.",
                    func = function()
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo("[Refresh (Dev Tool)] 已刷新统计文件列表 ツ")
                    end
                },

                Copy = {
                    hash = J("SN_Editor_StatsCopy"),
                    name = "Copy Folder Path",
                    type = eFeatureType.Button,
                    desc = "Copies the stats folder path to the clipboard.",
                    func = function()
                        FileMgr.CreateStatsDir()
                        Helper.RefreshFiles()
                        ImGui.SetClipboardText(STATS_DIR)
                        SilentLogger.LogInfo("[Copy (Dev Tool)] 已复制统计文件夹路径 ツ")
                    end
                },

                Generate = {
                    hash = J("SN_Editor_StatsGenerate"),
                    name = "Generate Example File",
                    type = eFeatureType.Button,
                    desc = "Generates the example stats file.",
                    func = function()
                        FileMgr.CreateStatsDir(true)
                        Helper.RefreshFiles()
                        SilentLogger.LogInfo("[Generate (Dev Tool)] 已生成示例统计文件 ツ")
                    end
                }
            },

            PackedStats = {
                Range = {
                    hash = J("SN_Editor_PackedStatsRange"),
                    name = "Range",
                    type = eFeatureType.Toggle,
                    desc = "Allows to set a range of packed stats.",
                    func = function(ftr)
                        SilentLogger.LogInfo(F("[Range (Packed Stats)] 范围模式已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                    end
                },

                Type = {
                    hash = J("SN_Editor_PackedStatsType"),
                    name = "Type",
                    type = eFeatureType.Combo,
                    desc = "Select the desired packed stat type.",
                    list = eTable.Editor.PackedStats.Types,
                    func = function(ftr)
                        local list  = eTable.Editor.PackedStats.Types
                        local index = list[ftr:GetListIndex() + 1].index
                        SilentLogger.LogInfo(F("[Type (Packed Stats)] 已选择打包统计项类型：%s ツ", list:GetName(index)))
                    end
                },

                PackedStat = {
                    hash = J("SN_Editor_PackedStatsPackedStat"),
                    name = "22050",
                    type = eFeatureType.InputText,
                    desc = "Input your packed stat here."
                },

                Value = {
                    hash = J("SN_Editor_PackedStatsValue"),
                    name = "5",
                    type = eFeatureType.InputText,
                    desc = "Input your value here."
                },

                Read = {
                    hash = J("SN_Editor_PackedStatsRead"),
                    name = "Read",
                    type = eFeatureType.Button,
                    desc = "Reads the entered packed stat value.",
                    func = function()
                        SilentLogger.LogInfo("[Read (Dev Tool)] 已从打包统计项读取值 ツ")
                    end
                },

                Write = {
                    hash = J("SN_Editor_PackedStatsWrite"),
                    name = "Write",
                    type = eFeatureType.Button,
                    desc = "ATTENTION: for advanced users.\nWrites the selected value to the entered packed stat.",
                    func = function(type, firstPStat, lastPStat, value)
                        local SetValue = {
                            ["int"]  = eNative.STATS.SET_PACKED_STAT_INT_CODE,
                            ["bool"] = eNative.STATS.SET_PACKED_STAT_BOOL_CODE
                        }

                        if lastPStat == nil then
                            SetValue[type](firstPStat, value, eStat.MPPLY_LAST_MP_CHAR:Get())
                            SilentLogger.LogInfo("[Write (Dev Tool)] 已将值写入打包统计项 ツ")
                            return
                        end

                        for i = firstPStat, lastPStat do
                            SetValue[type](i, value, eStat.MPPLY_LAST_MP_CHAR:Get())
                        end

                        TEMP_PSTAT = "TEMP"
                        SilentLogger.LogInfo("[Write (Dev Tool)] 已将值写入批量打包统计项 ツ")
                    end
                },

                Revert = {
                    hash = J("SN_Editor_PackedStatsRevert"),
                    name = "Revert",
                    type = eFeatureType.Button,
                    desc = "Reverts the previous value you've written to the entered packed stat.",
                    func = function(type, packedStat)
                        local SetValue = {
                            ["int"]  = eNative.STATS.SET_PACKED_STAT_INT_CODE,
                            ["bool"] = eNative.STATS.SET_PACKED_STAT_BOOL_CODE
                        }

                        if TEMP_PSTAT ~= "TEMP" then
                            SetValue[type](packedStat, TEMP_PSTAT, eStat.MPPLY_LAST_MP_CHAR:Get())
                            TEMP_PSTAT = "TEMP"
                        end

                        SilentLogger.LogInfo("[Revert (Dev Tool)] 已还原打包统计项值 ツ")
                    end
                }
            }
        }
    },

    Settings = {
        Config = {
            Open = {
                hash = J("SN_Settings_CAutoOpen"),
                name = "Auto-Open Lua Tab",
                type = eFeatureType.Toggle,
                desc = "Automatically opens Lua Tab upon running the script.",
                func = function(ftr)
                    CONFIG.autoopen = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedAutoOpen then
                        loggedAutoOpen = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Auto-Open Lua Tab (Settings)] 自动打开功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            Logging = {
                hash = J("SN_Settings_CLogging"),
                name = "Logging",
                type = eFeatureType.Combo,
                desc = "Disabled: no logging.\nSilent: logs only.\nEnabled: logs & toasts.",
                list = eTable.Settings.Logging,
                func = function(ftr)
                    CONFIG.logging = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list = eTable.Settings.Logging
                    SilentLogger.LogInfo(F("[Logging (Settings)] 已选择日志级别：%s ツ", list:GetName(CONFIG.logging)))
                end
            },

            Reset = {
                hash = J("SN_Settings_CReset"),
                name = "Reset",
                type = eFeatureType.Button,
                desc = "ATTENTION: cannot be undone.\nResets the config to default.",
                func = function()
                    loggedAcknowledgment  = CONFIG.easy_money.acknowledge
                    loggedAutoOpen        = CONFIG.autoopen
                    loggedJinxScript      = CONFIG.collab.jinxscript.enabled
                    loggedJinxScriptStop  = CONFIG.collab.jinxscript.autostop
                    loggedUCayoPerico     = CONFIG.unlock_all_poi.cayo_perico
                    loggedUDiamondCasino  = CONFIG.unlock_all_poi.diamond_casino
                    loggedAutoRegister    = CONFIG.register_as_boss.autoregister
                    loggedAutoDeposit     = CONFIG.easy_money.autodeposit
                    loggedDummyPrevention = CONFIG.easy_money.dummy_prevention
                    loggedAllow300kLoop   = CONFIG.easy_money.allow_300k_loop
                    FileMgr.ResetConfig()
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                    SilentLogger.LogInfo("[Reset (Settings)] 配置已重置为默认值 ツ")
                end
            },

            Copy = {
                hash = J("SN_Settings_CCopy"),
                name = "Copy Folder Path",
                type = eFeatureType.Button,
                desc = "Copies the config folder path to the clipboard.",
                func = function()
                    ImGui.SetClipboardText(CONFIG_DIR)
                    SilentLogger.LogInfo("[Copy Folder Path (Settings)] 已复制配置文件夹路径 ツ")
                end
            },

            Discord = {
                hash = J("SN_Settings_CDiscord"),
                name = "Copy Discord Invite Link",
                type = eFeatureType.Button,
                desc = "Copies Discord server invite link to your clipboard.",
                func = function()
                    ImGui.SetClipboardText(DISCORD)
                    SilentLogger.LogInfo("[Copy Discord Invite Link (Settings)] 已复制Discord服务器邀请链接 ツ")
                end
            },

            Unload = {
                hash = J("SN_Settings_CUnload"),
                name = F("Unload %s", SCRIPT_NAME),
                type = eFeatureType.Button,
                desc = F("Unloads the %s script.", SCRIPT_NAME),
                func = function()
                    SetShouldUnload()
                end
            }
        },

        Translation = {
            File = {
                hash = J("SN_Settings_TFile"),
                name = "Language",
                type = eFeatureType.Combo,
                desc = "Select the desired translation.",
                list = eTable.Settings.Languages,
                func = function(ftr)
                    local list      = eTable.Settings.Languages
                    local index     = list[ftr:GetListIndex() + 1].index
                    CONFIG.language = list:GetName(index)
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                    SilentLogger.LogInfo(F("[Language (Settings)] 已选择语言：%s ツ", list:GetName(index)))
                end
            },

            Load = {
                hash = J("SN_Settings_TLoad"),
                name = "Load",
                type = eFeatureType.Button,
                desc = "Loads the selected translation.",
                func = function(file)
                    local path = F("%s\\%s.json", TRANS_DIR, file)

                    if FileMgr.DoesFileExist(path) then
                        Script.Translate(path)
                        SilentLogger.LogInfo(F("[Load (Settings)] 已加载翻译文件«%s» ツ", file))
                        return
                    else
                        SilentLogger.LogError(F("[Load (Settings)] 翻译文件«%s»不存在 ツ", file))
                    end

                    CONFIG.language = "EN"
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    Helper.RefreshFiles()
                    Script.LoadDefaultTranslation()
                end
            },

            Remove = {
                hash = J("SN_Settings_TRemove"),
                name = "Remove",
                type = eFeatureType.Button,
                desc = "ATTENTION: cannot be undone.\nRemoves the selected translation.",
                func = function(file)
                    local path = F("%s\\%s.json", TRANS_DIR, file)

                    if file == "EN" then
                        SilentLogger.LogError("[Remove (Settings)] 无法移除默认翻译文件 ツ")
                        return
                    end

                    if FileMgr.DoesFileExist(path) then
                        FileMgr.DeleteFile(path)
                        SilentLogger.LogInfo(F("[Remove (Settings)] 已删除翻译文件«%s» ツ", file))
                    else
                        SilentLogger.LogError(F("[Remove (Settings)] 翻译文件«%s»不存在 ツ", file))
                    end

                    CONFIG.language = "EN"
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    Helper.RefreshFiles()
                    Script.LoadDefaultTranslation()
                end
            },

            Refresh = {
                hash = J("SN_Settings_TRefresh"),
                name = "Refresh",
                type = eFeatureType.Button,
                desc = "Refreshes the list of translations.",
                func = function()
                    Helper.RefreshFiles()
                    SilentLogger.LogInfo("[Refresh (Settings)] 已刷新翻译文件列表 ツ")
                end
            },

            Export = {
                hash = J("SN_Settings_TExport"),
                name = "Export",
                type = eFeatureType.Button,
                desc = "Exports the current translation to the file.",
                func = function(file)
                    FileMgr.ExportTranslation(file)
                    SilentLogger.LogInfo(F("[Export (Settings)] 已导出翻译文件«%s» ツ", file))
                end
            },

            Copy = {
                hash = J("SN_Settings_TCopy"),
                name = "Copy Folder Path",
                type = eFeatureType.Button,
                desc = "Copies the translations folder path to the clipboard.",
                func = function()
                    ImGui.SetClipboardText(TRANS_DIR)
                    SilentLogger.LogInfo("[Copy Folder Path (Settings)] 已复制翻译文件夹路径 ツ")
                end
            }
        },

        Collab = {
            JinxScript = {
                Toggle = {
                    hash = J("SN_Settings_CJinxScriptToggle"),
                    name = "JinxScript",
                    type = eFeatureType.Toggle,
                    desc = "JinxScript might help speed up some processes.",
                    func = function(ftr)
                        CONFIG.collab.jinxscript.enabled = ftr:IsToggled()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                        if loggedJinxScript then
                            loggedJinxScript = false
                            return
                        end

                        SilentLogger.LogInfo(F("[JinxScript (Settings)] JinxScript协作功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                    end
                },

                Discord = {
                    hash = J("SN_Settings_CJinxScriptDiscord"),
                    name = "Discord",
                    type = eFeatureType.Button,
                    desc = "Copies JinxScript Discord server invite link to your clipboard.",
                    func = function()
                        ImGui.SetClipboardText("https://discord.gg/hjs5S93kQv")
                        SilentLogger.LogInfo("[Discord (Settings)] 已复制JinxScript Discord服务器邀请链接 ツ")
                    end
                },

                Stop = {
                    hash = J("SN_Settings_CJinxScriptStop"),
                    name = "Auto-Stop JinxScript",
                    type = eFeatureType.Toggle,
                    desc = "Automatically stops JinxScript after using it in collab's features.",
                    func = function(ftr)
                        CONFIG.collab.jinxscript.autostop = ftr:IsToggled()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                        if loggedJinxScriptStop then
                            loggedJinxScriptStop = false
                            return
                        end

                        SilentLogger.LogInfo(F("[Auto-Stop JinxScript (Settings)] 自动停止JinxScript功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                    end
                }
            }
        },

        InstantFinish = {
            Agency = {
                hash = J("SN_Settings_IAgency"),
                name = "Agency",
                type = eFeatureType.Combo,
                desc = "Old: slower, works for all players, saves the preps, doesn't work for «Studio Time».\nNew: faster, works for most players, resets the preps, does work for «Studio Time».",
                func = function(ftr)
                    CONFIG.instant_finish.agency = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list  = eTable.Settings.InstantFinishes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Agency (Settings)] 已选择即时完成方式：%s ツ", list:GetName(ftr:GetListIndex())))
                end
            },

            Apartment = {
                hash = J("SN_Settings_IApartment"),
                name = "Apartment",
                type = eFeatureType.Combo,
                desc = "Old: slower, works for all players, saves the preps, doesn't work for preps.\nNew: faster, works for most players, resets the preps, works for preps.",
                func = function(ftr)
                    CONFIG.instant_finish.apartment = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list = eTable.Settings.InstantFinishes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Apartment (Settings)] 已选择即时完成方式：%s ツ", list:GetName(index)))
                end
            },

            AutoShop = {
                hash = J("SN_Settings_IAutoShop"),
                name = "Auto Shop",
                type = eFeatureType.Combo,
                desc = "Old: slower, works for all players, saves the preps.\nNew: faster, works for most players, resets the preps.",
                func = function(ftr)
                    CONFIG.instant_finish.auto_shop = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list  = eTable.Settings.InstantFinishes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Auto Shop (Settings)] 已选择即时完成方式：%s ツ", list:GetName(index)))
                end
            },

            CayoPerico = {
                hash = J("SN_Settings_ICayoPerico"),
                name = "Cayo Perico",
                type = eFeatureType.Combo,
                desc = "Old: slower, works for all players, saves the preps.\nNew: faster, works for most players, resets the preps.",
                func = function(ftr)
                    CONFIG.instant_finish.cayo_perico = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list = eTable.Settings.InstantFinishes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Cayo Perico (Settings)] 已选择即时完成方式：%s ツ", list:GetName(index)))
                end
            },

            DiamondCasino = {
                hash = J("SN_Settings_IDiamondCasino"),
                name = "Diam. Casino",
                type = eFeatureType.Combo,
                desc = "Old: slower, works for all players, saves the preps.\nNew: faster, works for most players, resets the preps.",
                func = function(ftr)
                    CONFIG.instant_finish.diamond_casino = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list = eTable.Settings.InstantFinishes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Diamond Casino (Settings)] 已选择即时完成方式：%s ツ", list:GetName(index)))
                end
            },

            Doomsday = {
                hash = J("SN_Settings_IDoomsday"),
                name = "Doomsday",
                type = eFeatureType.Combo,
                desc = "Old: slower, works for all players, saves the preps, doesn't work for «Act III«.\nNew: faster, works for most players, resets the preps, does work for «Act III».",
                func = function(ftr)
                    CONFIG.instant_finish.doomsday = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    local list  = eTable.Settings.InstantFinishes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Doomsday (Settings)] 已选择即时完成方式：%s ツ", list:GetName(index)))
                end
            }
        },

        UnlockAllPoi = {
            CayoPerico = {
                hash = J("SN_Settings_UCayoPerico"),
                name = "Cayo Perico",
                type = eFeatureType.Toggle,
                desc = "«Apply & Complete Preps» will automatically unlock all points of interest.",
                func = function(ftr)
                    CONFIG.unlock_all_poi.cayo_perico = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedUCayoPerico then
                        loggedUCayoPerico = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Cayo Perico (Settings)] 解锁全部兴趣点功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            DiamondCasino = {
                hash = J("SN_Settings_UDiamondCasino"),
                name = "Diamond Casino",
                type = eFeatureType.Toggle,
                desc = "«Apply & Complete Preps» will automatically unlock all points of interest.",
                func = function(ftr)
                    CONFIG.unlock_all_poi.diamond_casino = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedUDiamondCasino then
                        loggedUDiamondCasino = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Diamond Casino (Settings)] 解锁全部兴趣点功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            }
        },

        RegisterAsBoss = {
            AutoRegister = {
                hash = J("SN_Settings_RAutoRegister"),
                name = "Auto-Register",
                type = eFeatureType.Toggle,
                desc = "ATTENTION: might cause issues during missions.\nAutomatically tries to register you as a boss while the script is running.",
                func = function(ftr)
                    CONFIG.register_as_boss.autoregister = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedAutoRegister then
                        loggedAutoRegister = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Auto-Register (Settings)] 自动注册功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            Type = {
                hash = J("SN_Settings_RType"),
                name = "Type",
                type = eFeatureType.Combo,
                desc = "Select the desired organization type.",
                list = eTable.Settings.OrgTypes,
                func = function(ftr)
                    CONFIG.register_as_boss.type = ftr:GetListIndex()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if CONFIG.register_as_boss.autoregister then
                        eGlobal.Player.Organization.CEO:Set(-1)
                    end

                    local list  = eTable.Settings.OrgTypes
                    local index = list[ftr:GetListIndex() + 1].index
                    SilentLogger.LogInfo(F("[Type (Settings)] 已选择组织类型：%s ツ", list:GetName(index)))
                end
            }
        },

        EasyMoney = {
            AutoDeposit = {
                hash = J("SN_Settings_AutoDeposit"),
                name = "Auto-Deposit",
                type = eFeatureType.Toggle,
                desc = "Automatically deposits money from wallet into your bank account while using some loops.",
                func = function(ftr)
                    CONFIG.easy_money.autodeposit = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedAutoDeposit then
                        loggedAutoDeposit = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Auto-Deposit (Settings)] 自动存款功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            Prevention = {
                hash = J("SN_Settings_Prevention"),
                name = "Dummy Prevention",
                type = eFeatureType.Toggle,
                desc = "RECOMMENDED: don't disable.\nPrevents enabling multiple «Easy Money» loops simultaneously.",
                func = function(ftr)
                    CONFIG.easy_money.dummy_prevention = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedDummyPrevention then
                        loggedDummyPrevention = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Dummy Prevention (Settings)] 防重复启用功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            Allow300k = {
                hash = J("SN_Settings_Allow300k"),
                name = "Allow 300k Loop Outside",
                type = eFeatureType.Toggle,
                desc = "Allows using 300k Loop outside of the Nightclub, but the loop will be a bit slower.",
                func = function(ftr)
                    CONFIG.easy_money.allow_300k_loop = ftr:IsToggled()
                    FileMgr.SaveConfig(CONFIG)
                    CONFIG = Json.DecodeFromFile(CONFIG_PATH)

                    if loggedAllow300kLoop then
                        loggedAllow300kLoop = false
                        return
                    end

                    SilentLogger.LogInfo(F("[Allow 300k Loop Outside (Settings)] 允许30万循环在夜总会外使用功能已%s ツ", (ftr:IsToggled()) and "启用" or "禁用"))
                end
            },

            Delay = {
                _5k = {
                    hash = J("SN_Settings_5k"),
                    name = "5k Loop",
                    type = eFeatureType.SliderFloat,
                    desc = "Changes the delay between transactions. Try to increase if you get transaction errors.",
                    lims = { 1.0, 5.0 },
                    func = function(ftr)
                        CONFIG.easy_money.delay._5k = ftr:GetFloatValue()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                        SilentLogger.LogInfo("[5k Loop (Settings)] 已修改延迟 ツ")
                    end
                },

                _50k = {
                    hash = J("SN_Settings_50k"),
                    name = "50k Loop",
                    type = eFeatureType.SliderFloat,
                    desc = "Changes the delay between transactions. Try to increase if you get transaction errors.",
                    lims = { 0.333, 5.0 },
                    func = function(ftr)
                       CONFIG.easy_money.delay._50k = ftr:GetFloatValue()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                        SilentLogger.LogInfo("[50k Loop (Settings)] 已修改延迟 ツ")
                    end
                },

                _100k = {
                    hash = J("SN_Settings_100k"),
                    name = "100k Loop",
                    type = eFeatureType.SliderFloat,
                    desc = "Changes the delay between transactions. Try to increase if you get transaction errors.",
                    lims = { 0.333, 5.0 },
                    func = function(ftr)
                        CONFIG.easy_money.delay._100k = ftr:GetFloatValue()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                        SilentLogger.LogInfo("[100k Loop (Settings)] 已修改延迟 ツ")
                    end
                },

                _180k = {
                    hash = J("SN_Settings_180k"),
                    name = "180k Loop",
                    type = eFeatureType.SliderFloat,
                    desc = "Changes the delay between transactions. Try to increase if you get transaction errors.",
                    lims = { 0.333, 5.0 },
                    func = function(ftr)
                        CONFIG.easy_money.delay._180k = ftr:GetFloatValue()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                        SilentLogger.LogInfo("[180k Loop (Settings)] 已修改延迟 ツ")
                    end
                },

                _300k = {
                    hash = J("SN_Settings_300k"),
                    name = "300k Loop",
                    type = eFeatureType.SliderFloat,
                    desc = "Changes the delay between transactions. Try to increase if you get transaction errors.",
                    lims = { (GTA_EDITION == "EE") and 1.0 or 1.5, 5.0 },
                    func = function(ftr)
                        CONFIG.easy_money.delay._300k = ftr:GetFloatValue()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                        SilentLogger.LogInfo("[300k Loop (Settings)] 已修改延迟 ツ")
                    end
                },

                _680k = {
                    hash = J("SN_Settings_680k"),
                    name = "680k Loop",
                    type = eFeatureType.SliderFloat,
                    desc = "Changes the delay between transactions. Try to increase if you get transaction errors.",
                    lims = { 0.333, 5.0 },
                    func = function(ftr)
                        CONFIG.easy_money.delay._680k = ftr:GetFloatValue()
                        FileMgr.SaveConfig(CONFIG)
                        CONFIG = Json.DecodeFromFile(CONFIG_PATH)
                        SilentLogger.LogInfo("[680k Loop (Settings)] 已修改延迟 ツ")
                    end
                }
            }
        }
    }
}

--#endregion
