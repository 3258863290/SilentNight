--#region Renderer

Renderer = {}

--#region 渲染器

Renderer = {}

-- 渲染抢劫工具界面
function Renderer.RenderHeistTool()
    if ImGui.BeginTabItem("抢劫工具") then
        if ImGui.BeginTabBar("抢劫标签页") then
            if ImGui.BeginTabItem("事务所") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("准备任务") then
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Preps.Contract)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Preps.Complete)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("启动控制") then
                        Helper.RenderLaunchSettings(1, eFeature.Heist.CayoPerico.Launch.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Launch.Reset)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Misc.Teleport.Computer)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Misc.Teleport.Mission)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Skip)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Misc.Cooldown)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Payout.Select)
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Payout.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Agency.Payout.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("公寓") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("准备任务") then
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Preps.Complete)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Preps.Reload)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Preps.Change)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("预设") then
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.File)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.Load)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.Remove)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.Refresh)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.Name)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.Save)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Presets.Copy)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("启动控制") then
                        local reqPlayers = eLocal.Heist.Generic.Launch.Step2:Get()
                        local isFleeca   = eStat.HEIST_MISSION_RCONT_ID_1:Get() == eTable.Heist.Apartment.Heists.FleecaJob

                        Helper.RenderLaunchSettings((isFleeca) and 2 or 4, eFeature.Heist.Apartment.Launch.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Launch.Solo)

                        if reqPlayers ~= 0 and reqPlayers ~= ((isFleeca) and 2 or 4) then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Launch.Reset)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Teleport.Board)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Skip)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Force)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.FleecaHack)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.FleecaDrill)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.PacificHack)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Cooldown)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Play)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Misc.Unlock)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Bonus)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Double)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Presets)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player1.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player1.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player2.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player2.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player3.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player3.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player4.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Player4.Cut)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.Apartment.Cuts.Apply)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("改装铺") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("准备任务") then
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Preps.Contract)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Preps.Complete)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Preps.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Preps.Reload)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("启动控制") then
                        Helper.RenderLaunchSettings(1, eFeature.Heist.CayoPerico.Launch.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Launch.Reset)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Misc.Teleport.Board)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Skip)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Misc.Cooldown)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Payout.Select)
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Payout.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.AutoShop.Payout.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("佩里科岛") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("准备任务") then
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Difficulty)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Approach)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Loadout)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Primary)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Secondary.Compound)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Amount.Compound)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Amount.Arts)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Secondary.Island)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Amount.Island)
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Advanced)
                        ImGui.ResetFrameBgStyle()

                        if FeatureMgr.GetFeatureBool(eFeature.Heist.CayoPerico.Preps.Advanced) then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Default)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Cash)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Weed)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Coke)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Gold)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Arts)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Complete)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Preps.Reload)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("预设") then
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.File)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.Load)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.Remove)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.Refresh)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.Name)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.Save)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Presets.Copy)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("启动控制") then
                        Helper.RenderLaunchSettings(1, eFeature.Heist.CayoPerico.Launch.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Launch.Reset)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Teleport)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Skip)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Force)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.FingerprintHack)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.PlasmaCutterCut)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.DrainagePipeCut)
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Bag)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Solo)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Team)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Offline)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Online)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Crew)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Presets)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player1.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player1.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player2.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player2.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player3.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player3.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player4.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Player4.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.CayoPerico.Cuts.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("非房主") then
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("钻石赌场") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("准备任务") then
						ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Difficulty)
						ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Approach)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Gunman)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Loadout)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Driver)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Vehicles)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Hacker)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Masks)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Keycards)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Guards)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Target)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Complete)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Preps.Reload)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("预设") then
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.File)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.Load)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.Remove)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.Refresh)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.Name)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.Save)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Presets.Copy)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("启动控制") then
                        local reqPlayers = eLocal.Heist.Generic.Launch.Step2:Get()

                        Helper.RenderLaunchSettings(2, eFeature.Heist.DiamondCasino.Launch.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Launch.Solo)

                        if reqPlayers ~= 0 and reqPlayers ~= 2 then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Launch.Reset)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Setup)
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Teleport.Board)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Skip)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Force)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.FingerprintHack)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.KeypadHack)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.VaultDoorDrill)
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Autograbber)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Misc.Cooldown)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Crew)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Presets)
						ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player1.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player1.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player2.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player2.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player3.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player3.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player4.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Player4.Cut)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.DiamondCasino.Cuts.Apply)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("非房主") then
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("末日豪劫") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("准备任务") then
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Preps.Act)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Preps.Complete)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Preps.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Preps.Reload)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("预设") then
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.File)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.Load)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.Remove)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.Refresh)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.Name)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.Save)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Presets.Copy)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("启动控制") then
                        local reqPlayers = eLocal.Heist.Generic.Launch.Step2:Get()

                        Helper.RenderLaunchSettings(2, eFeature.Heist.Doomsday.Launch.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Launch.Solo)

                        if reqPlayers ~= 0 and reqPlayers ~= 2 then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Launch.Reset)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Misc.Teleport.Screen)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Skip)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Misc.Force)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Misc.DataHack)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Misc.DoomsdayHack)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Presets)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player1.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player1.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player2.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player2.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player3.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player3.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player4.Toggle)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Player4.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Doomsday.Cuts.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("非房主") then
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cut)
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("废品场") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("插槽1") then
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot1.Available)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot1.Robbery)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot1.Vehicle)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot1.Modification)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot1.Keep)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot1.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("准备任务") then
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Preps.Apply)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Preps.Complete)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Preps.Reset)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Preps.Reload)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Preps.Free.Setup)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Preps.Free.Claim)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("插槽2") then
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot2.Available)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot2.Robbery)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot2.Vehicle)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot2.Modification)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot2.Keep)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot2.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Misc.Teleport.Board)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.Generic.Cutscene)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Misc.Finish)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Misc.Sell)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Misc.Force)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Misc.Cooldown)

                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("插槽3") then
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot3.Available)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot3.Robbery)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot3.Vehicle)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot3.Modification)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot3.Keep)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Slot3.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("分红") then
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Payout.Salvage)
                        ImGui.ResetButtonStyle()
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Payout.Slot1)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Payout.Slot2)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Payout.Slot3)
                        ClickGUI.RenderFeature(eFeature.Heist.SalvageYard.Payout.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end
            ImGui.EndTabBar()
        end
        ImGui.EndTabItem()
    end
end

-- 渲染产业工具界面
function Renderer.RenderBusinessTool()
    if ImGui.BeginTabItem("产业工具") then
        if ImGui.BeginTabBar("产业标签页") then
            if ImGui.BeginTabItem("地堡") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("出售") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Sale.Price)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Sale.NoXp)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Sale.Sell)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Misc.Teleport.Laptop)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Misc.Open)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Misc.Supply)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Misc.Trigger)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Misc.Supplier)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("统计") then
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Stats.SellMade)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Stats.SellUndertaken)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Stats.Earnings)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Stats.NoSell)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Stats.NoEarnings)
                        ClickGUI.RenderFeature(eFeature.Business.Bunker.Stats.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("机库货物") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("出售") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Sale.Price)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Sale.NoXp)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Sale.Sell)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Misc.Teleport.Laptop)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Misc.Open)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Misc.Supply)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Misc.Supplier)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Misc.Cooldown)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("统计") then
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.BuyMade)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.BuyUndertaken)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.SellMade)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.SellUndertaken)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.Earnings)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.NoBuy)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.NoSell)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.NoEarnings)
                        ClickGUI.RenderFeature(eFeature.Business.Hangar.Stats.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("洗钱门面") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("亲力亲为洗车行") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Teleport.Laptop)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Lock)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Min)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Select)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("总热度") then
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.OverallHeat.Lock)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.OverallHeat.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.OverallHeat.Min)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.OverallHeat.Select)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("水上烟店") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Teleport.Laptop)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Lock)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Min)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Select)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("希金斯直升机观光") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Teleport.Laptop)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Lock)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Min)
                        ClickGUI.RenderFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Select)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("夜总会") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("出售") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Sale.Price)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("保险箱") then
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Safe.Fill)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Safe.Collect)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Safe.Unbrick)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Misc.Setup)
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Misc.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Misc.Teleport.Computer)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Misc.Open)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Misc.Cooldown)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("人气值") then
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Popularity.Lock)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Popularity.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Popularity.Min)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Popularity.Select)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("统计") then
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Stats.SellMade)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Stats.Earnings)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Stats.NoSell)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Stats.NoEarnings)
                        ClickGUI.RenderFeature(eFeature.Business.Nightclub.Stats.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("特殊货物") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("出售") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Sale.Price)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Sale.NoXp)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Sale.NoCrateback)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Sale.Sell)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Teleport.Office)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Teleport.Computer)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Teleport.Warehouse)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Supply)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Select)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Max)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Buy)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Supplier)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Misc.Cooldown)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("统计") then
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.BuyMade)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.BuyUndertaken)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.SellMade)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.SellUndertaken)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.Earnings)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.NoBuy)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.NoSell)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.NoEarnings)
                        ClickGUI.RenderFeature(eFeature.Business.CrateWarehouse.Stats.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("杂项") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("补给") then
                        ClickGUI.RenderFeature(eFeature.Business.Misc.Supplies.Business)
                        ClickGUI.RenderFeature(eFeature.Business.Misc.Supplies.Resupply)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Business.Misc.Supplies.Refresh)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("服装工厂") then
                        ImGui.PushButtonStyle(eBtnStyle.PINK)
                        ClickGUI.RenderFeature(eFeature.Business.Misc.Garment.Teleport.Entrance)
                        ClickGUI.RenderFeature(eFeature.Business.Misc.Garment.Teleport.Computer)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Business.Misc.Garment.Unbrick)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end
            ImGui.EndTabBar()
        end
        ImGui.EndTabItem()
    end
end

-- 渲染金钱工具界面
function Renderer.RenderMoneyTool()
    if ImGui.BeginTabItem("金钱工具") then
        if ImGui.BeginTabBar("金钱标签页") then
            if ImGui.BeginTabItem("赌场") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("幸运轮盘") then
                        ClickGUI.RenderFeature(eFeature.Money.Casino.LuckyWheel.Select)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.LuckyWheel.Give)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("二十一点") then
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Blackjack.Card)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Blackjack.Reveal)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Blackjack.Trick)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("老虎机") then
                        ImGui.PushButtonStyle(eBtnStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Slots.Win)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Slots.Lose)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("扑克") then
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Poker.MyCards)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Poker.Cards)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Poker.Reveal)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Poker.Give)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Poker.Trick)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("轮盘赌") then
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Roulette.Land13)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Roulette.Land16)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("杂项") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Misc.Bypass)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Misc.Limit.Select)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Misc.Limit.Acquire)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Casino.Misc.Limit.Trade)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("快速赚钱") then
                if ImGui.BeginColumns(1) then
                    if ClickGUI.BeginCustomChildWindow("声明") then
                        local r, g, b, a = U(eBtnStyle.RED.Hovered)
                        ImGui.TextColored(1, 1, 1, 1, "使用前请务必仔细阅读所有功能说明！")
                        ImGui.TextColored(1, 1, 1, 1, "请注意，任何滥用功能的行为都可能导致账号被封禁！")
                        ImGui.TextColored(r, g, b, a, "请负责任地使用这些功能，风险自负！")
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Acknowledge)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end

                if ImGui.BeginColumns(2) then
                    if ClickGUI.BeginCustomChildWindow("自由模式") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Freeroam._5k)
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Freeroam._50k)
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Freeroam._100k)
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Freeroam._180k)
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Freeroam._680k)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("房产") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.RED)
                        ClickGUI.RenderFeature(eFeature.Money.EasyMoney.Property._300k)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end

            if ImGui.BeginTabItem("杂项") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("编辑") then
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Edit.DepositAll)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Edit.WithdrawAll)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Edit.Select)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Edit.Deposit)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Edit.Withdraw)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Edit.Remove)
                        ImGui.ResetButtonStyle()
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("故事模式") then
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Story.Select)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Story.Character)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Story.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("统计") then
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Stats.Select)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Stats.Earned)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Stats.Spent)
                        ClickGUI.RenderFeature(eFeature.Money.Misc.Stats.Apply)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end
            ImGui.EndTabBar()
        end
        ImGui.EndTabItem()
    end
end

-- 渲染开发工具界面
function Renderer.RenderDevTool()
    if ImGui.BeginTabItem("开发工具") then
        if ImGui.BeginTabBar("开发标签页") then
            if ImGui.BeginTabItem("编辑器") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("全局变量") then
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Globals.Type)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Globals.Global)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Globals.Value)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Globals.Read)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Globals.Write)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Globals.Revert)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("打包统计") then
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.Range)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.Type)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.PackedStat)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.Value)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.Read)

                        if FeatureMgr.GetFeature(eFeature.Dev.Editor.PackedStats.Read):IsVisible() then
                            ImGui.SameLine()
                        end

                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.Write)
                        ImGui.ResetButtonStyle()

                        if FeatureMgr.GetFeature(eFeature.Dev.Editor.PackedStats.Write):GetName() == "Write" then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Dev.Editor.PackedStats.Revert)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("本地变量") then
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Type)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Script)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Local)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Value)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Read)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Write)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Locals.Revert)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("统计") then
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.From)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Type)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Stat)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Value)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Read)

                        if FeatureMgr.GetFeature(eFeature.Dev.Editor.Stats.Read):IsVisible() then
                            ImGui.SameLine()
                        end

                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Write)
                        ImGui.ResetButtonStyle()

                        if FeatureMgr.GetFeature(eFeature.Dev.Editor.Stats.Write):IsVisible() then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Revert)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.File)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.WriteAll)

                        if FeatureMgr.GetFeature(eFeature.Dev.Editor.Stats.WriteAll):IsVisible() then
                            ImGui.SameLine()
                        end

                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Remove)
                        ImGui.ResetButtonStyle()

                        if FeatureMgr.GetFeature(eFeature.Dev.Editor.Stats.Remove):IsVisible() then
                            ImGui.SameLine()
                        end

                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Refresh)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Copy)
                        ClickGUI.RenderFeature(eFeature.Dev.Editor.Stats.Generate)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end
            ImGui.EndTabBar()
        end
        ImGui.EndTabItem()
    end
end

-- 渲染设置界面
function Renderer.RenderSettings()
    if ImGui.BeginTabItem("设置") then
        if ImGui.BeginTabBar("设置标签页") then
            if ImGui.BeginTabItem("配置") then
                if ImGui.BeginColumns(3) then
                    if ClickGUI.BeginCustomChildWindow("配置 & 社交平台") then
                        ClickGUI.RenderFeature(eFeature.Settings.Config.Open)
                        ClickGUI.RenderFeature(eFeature.Settings.Config.Logging)
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Settings.Config.Reset)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Settings.Config.Copy)
                        ImGui.PushButtonStyle(eBtnStyle.DISCORD)
                        ClickGUI.RenderFeature(eFeature.Settings.Config.Discord)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Settings.Config.Unload)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("翻译") then
                        ClickGUI.RenderFeature(eFeature.Settings.Translation.File)
                        ClickGUI.RenderFeature(eFeature.Settings.Translation.Load)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Settings.Translation.Remove)
                        ImGui.ResetButtonStyle()
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Settings.Translation.Refresh)
                        ClickGUI.RenderFeature(eFeature.Settings.Translation.Export)
                        ImGui.SameLine()
                        ClickGUI.RenderFeature(eFeature.Settings.Translation.Copy)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("合作项") then
                        ClickGUI.RenderFeature(eFeature.Settings.Collab.JinxScript.Toggle)
                        ImGui.SameLine()
                        ImGui.PushButtonStyle(eBtnStyle.DISCORD)
                        ClickGUI.RenderFeature(eFeature.Settings.Collab.JinxScript.Discord)
                        ImGui.ResetButtonStyle()
                        ClickGUI.RenderFeature(eFeature.Settings.Collab.JinxScript.Stop)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("立即完成") then
                        ClickGUI.RenderFeature(eFeature.Settings.InstantFinish.Agency)
                        ClickGUI.RenderFeature(eFeature.Settings.InstantFinish.Apartment)
                        ClickGUI.RenderFeature(eFeature.Settings.InstantFinish.AutoShop)
                        ClickGUI.RenderFeature(eFeature.Settings.InstantFinish.CayoPerico)
                        ClickGUI.RenderFeature(eFeature.Settings.InstantFinish.DiamondCasino)
                        ClickGUI.RenderFeature(eFeature.Settings.InstantFinish.Doomsday)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("解锁所有兴趣点") then
                        ClickGUI.RenderFeature(eFeature.Settings.UnlockAllPoi.CayoPerico)
                        ClickGUI.RenderFeature(eFeature.Settings.UnlockAllPoi.DiamondCasino)
                        ClickGUI.EndCustomChildWindow()
                    end

                    if ClickGUI.BeginCustomChildWindow("注册为老板") then
                        ImGui.PushFrameBgStyle(eFrameBgStyle.ORANGE)
                        ClickGUI.RenderFeature(eFeature.Settings.RegisterAsBoss.AutoRegister)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Settings.RegisterAsBoss.Type)
                        ClickGUI.EndCustomChildWindow()
                    end

                    ImGui.TableNextColumn()

                    if ClickGUI.BeginCustomChildWindow("快速赚钱") then
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.AutoDeposit)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Allow300k)
                        ImGui.PushFrameBgStyle(eFrameBgStyle.GREEN)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Prevention)
                        ImGui.ResetFrameBgStyle()
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Delay._5k)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Delay._50k)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Delay._100k)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Delay._180k)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Delay._300k)
                        ClickGUI.RenderFeature(eFeature.Settings.EasyMoney.Delay._680k)
                        ClickGUI.EndCustomChildWindow()
                    end
                    ImGui.EndColumns()
                end
                ImGui.EndTabItem()
            end
            ImGui.EndTabBar()
        end
        ImGui.EndTabItem()
    end
end

-- 渲染点击式图形界面
function Renderer.RenderClickGUI()
    if ImGui.BeginTabBar(SCRIPT_NAME) then
        Renderer.RenderHeistTool()
        Renderer.RenderBusinessTool()
        Renderer.RenderMoneyTool()
        Renderer.RenderDevTool()
        Renderer.RenderSettings()
        ImGui.EndTabBar()
    end
end

ClickGUI.AddTab(F("%s v%s %s", SCRIPT_NAME, SCRIPT_VER, GTA_EDITION), Renderer.RenderClickGUI)

-- 渲染列表式图形界面
function Renderer.RenderListGUI()
    local root = ListGUI.GetRootTab()
    if not root then return end

    local SilentNightTab = root:AddSubTab(F("%s v%s %s", SCRIPT_NAME, SCRIPT_VER, GTA_EDITION), SCRIPT_NAME)

    local HeistToolTab = SilentNightTab:AddSubTab("抢劫工具", "Heist Tool")
    if HeistToolTab then
        local AgencyTab = HeistToolTab:AddSubTab("事务所", "Agency")
        if AgencyTab then
            local prepsTab = AgencyTab:AddSubTab("准备任务", "Preps")

            prepsTab:AddFeature(eFeature.Heist.Agency.Preps.Contract)
            prepsTab:AddFeature(eFeature.Heist.Agency.Preps.Complete)

            local MiscTab = AgencyTab:AddSubTab("杂项", "Misc")
            MiscTab:AddFeature(eFeature.Heist.Agency.Misc.Teleport.Entrance)
            MiscTab:AddFeature(eFeature.Heist.Agency.Misc.Teleport.Computer)
            MiscTab:AddFeature(eFeature.Heist.Agency.Misc.Teleport.Mission)
            MiscTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscTab:AddFeature(eFeature.Heist.Generic.Skip)
            MiscTab:AddFeature(eFeature.Heist.Agency.Misc.Finish)
            MiscTab:AddFeature(eFeature.Heist.Agency.Misc.Cooldown)

            local payoutTab = AgencyTab:AddSubTab("分红", "Payouts")
            payoutTab:AddFeature(eFeature.Heist.Agency.Payout.Select)
            payoutTab:AddFeature(eFeature.Heist.Agency.Payout.Max)
            payoutTab:AddFeature(eFeature.Heist.Agency.Payout.Apply)
        end

        local ApartmentTab = HeistToolTab:AddSubTab("公寓", "Apartment")
        if ApartmentTab then
            local PrepsSubTab = ApartmentTab:AddSubTab("准备任务", "Preps")
            PrepsSubTab:AddFeature(eFeature.Heist.Apartment.Preps.Complete)
            PrepsSubTab:AddFeature(eFeature.Heist.Apartment.Preps.Reload)
            PrepsSubTab:AddFeature(eFeature.Heist.Apartment.Preps.Change)

            local PresetsSubTab = ApartmentTab:AddSubTab("预设", "Presets")
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.File)
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.Load)
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.Remove)
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.Refresh)
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.Name)
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.Save)
            PresetsSubTab:AddFeature(eFeature.Heist.Apartment.Presets.Copy)

            local LaunchSubTab = ApartmentTab:AddSubTab("启动控制", "Launch Control")
            LaunchSubTab:AddFeature(eFeature.Heist.Apartment.Launch.Solo)
            LaunchSubTab:AddFeature(eFeature.Heist.Apartment.Launch.Reset)

            local MiscSubTab = ApartmentTab:AddSubTab("杂项", "Misc")
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Teleport.Board)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Skip)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Force)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Finish)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.FleecaHack)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.FleecaDrill)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.PacificHack)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Cooldown)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Play)
            MiscSubTab:AddFeature(eFeature.Heist.Apartment.Misc.Unlock)

            local CutsSubTab = ApartmentTab:AddSubTab("分红", "Cuts")
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Bonus)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Double)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Presets)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player1.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player1.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player2.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player2.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player3.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player3.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player4.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Player4.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Apartment.Cuts.Apply)
        end

        local AutoShopTab = HeistToolTab:AddSubTab("改装铺", "Auto Shop")
        if AutoShopTab then
            local PrepsSubTab = AutoShopTab:AddSubTab("准备任务", "Preps")
            PrepsSubTab:AddFeature(eFeature.Heist.AutoShop.Preps.Contract)
            PrepsSubTab:AddFeature(eFeature.Heist.AutoShop.Preps.Complete)
            PrepsSubTab:AddFeature(eFeature.Heist.AutoShop.Preps.Reset)
            PrepsSubTab:AddFeature(eFeature.Heist.AutoShop.Preps.Reload)

            local MiscSubTab = AutoShopTab:AddSubTab("杂项", "Misc")
            MiscSubTab:AddFeature(eFeature.Heist.AutoShop.Misc.Teleport.Entrance)
MiscSubTab:AddFeature(eFeature.Heist.AutoShop.Misc.Teleport.Board)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Skip)
            MiscSubTab:AddFeature(eFeature.Heist.AutoShop.Misc.Finish)
            MiscSubTab:AddFeature(eFeature.Heist.AutoShop.Misc.Cooldown)

            local PayoutSubTab = AutoShopTab:AddSubTab("分红", "分红")
            PayoutSubTab:AddFeature(eFeature.Heist.AutoShop.Payout.Select)
            PayoutSubTab:AddFeature(eFeature.Heist.AutoShop.Payout.Max)
            PayoutSubTab:AddFeature(eFeature.Heist.AutoShop.Payout.Apply)
        end

        local CayoPericoTab = HeistToolTab:AddSubTab("佩里科岛", "佩里科岛")
        if CayoPericoTab then
            local PrepsSubTab = CayoPericoTab:AddSubTab("前置准备", "前置准备")
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Difficulty)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Approach)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Loadout)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Primary)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Secondary.Compound)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Amount.Compound)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Amount.Arts)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Secondary.Island)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Amount.Island)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Advanced)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Default)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Cash)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Weed)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Coke)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Gold)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Target.Value.Arts)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Complete)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Reset)
            PrepsSubTab:AddFeature(eFeature.Heist.CayoPerico.Preps.Reload)

            local PresetsSubTab = CayoPericoTab:AddSubTab("预设", "预设")
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.File)
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.Load)
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.Remove)
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.Refresh)
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.Name)
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.Save)
            PresetsSubTab:AddFeature(eFeature.Heist.CayoPerico.Presets.Copy)

            local LaunchSubTab = ApartmentTab:AddSubTab("启动控制", "启动控制")
            LaunchSubTab:AddFeature(eFeature.Heist.CayoPerico.Launch.Reset)

            local MiscSubTab = CayoPericoTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Teleport)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Skip)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Force)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Finish)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.FingerprintHack)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.PlasmaCutterCut)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.DrainagePipeCut)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Bag)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Solo)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Team)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Offline)
            MiscSubTab:AddFeature(eFeature.Heist.CayoPerico.Misc.Cooldown.Online)

            local CutsSubTab = CayoPericoTab:AddSubTab("分红", "分红")
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Crew)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Presets)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player1.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player1.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player2.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player2.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player3.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player3.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player4.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Player4.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.CayoPerico.Cuts.Apply)

            local NonHostTab = CayoPericoTab:AddSubTab("非房主", "非房主")
            NonHostTab:AddFeature(eFeature.Heist.Generic.Cut)
            NonHostTab:AddFeature(eFeature.Heist.Generic.Apply)
        end

        local CasinoHeistTab = HeistToolTab:AddSubTab("钻石赌场", "钻石赌场")
        if CasinoHeistTab then
            local PrepsSubTab = CasinoHeistTab:AddSubTab("前置准备", "前置准备")
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Difficulty)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Approach)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Gunman)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Loadout)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Driver)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Vehicles)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Hacker)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Masks)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Target)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Complete)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Reset)
            PrepsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Preps.Reload)

            local PresetsSubTab = CasinoHeistTab:AddSubTab("预设", "预设")
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.File)
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.Load)
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.Remove)
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.Refresh)
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.Name)
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.Save)
            PresetsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Presets.Copy)

            local LaunchSubTab = ApartmentTab:AddSubTab("启动控制", "启动控制")
            LaunchSubTab:AddFeature(eFeature.Heist.DiamondCasino.Launch.Solo)
            LaunchSubTab:AddFeature(eFeature.Heist.DiamondCasino.Launch.Reset)

            local MiscSubTab = CasinoHeistTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Setup)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Teleport.Board)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Skip)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Force)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Finish)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.FingerprintHack)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.KeypadHack)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.VaultDoorDrill)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Autograbber)
            MiscSubTab:AddFeature(eFeature.Heist.DiamondCasino.Misc.Cooldown)

            local CutsSubTab = CasinoHeistTab:AddSubTab("分红", "分红")
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Crew)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Presets)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player1.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player1.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player2.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player2.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player3.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player3.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player4.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Player4.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.DiamondCasino.Cuts.Apply)

            local NonHostTab = CasinoHeistTab:AddSubTab("非房主", "非房主")
            NonHostTab:AddFeature(eFeature.Heist.Generic.Cut)
            NonHostTab:AddFeature(eFeature.Heist.Generic.Apply)
        end

        local DoomsdayTab = HeistToolTab:AddSubTab("末日豪劫", "末日豪劫")
        if DoomsdayTab then
            local PrepsSubTab = DoomsdayTab:AddSubTab("前置准备", "前置准备")
            PrepsSubTab:AddFeature(eFeature.Heist.Doomsday.Preps.Act)
            PrepsSubTab:AddFeature(eFeature.Heist.Doomsday.Preps.Complete)
            PrepsSubTab:AddFeature(eFeature.Heist.Doomsday.Preps.Reset)
            PrepsSubTab:AddFeature(eFeature.Heist.Doomsday.Preps.Reload)

            local PresetsSubTab = DoomsdayTab:AddSubTab("预设", "预设")
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.File)
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.Load)
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.Remove)
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.Refresh)
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.Name)
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.Save)
            PresetsSubTab:AddFeature(eFeature.Heist.Doomsday.Presets.Copy)

            local LaunchSubTab = ApartmentTab:AddSubTab("启动控制", "启动控制")
            LaunchSubTab:AddFeature(eFeature.Heist.Doomsday.Launch.Solo)
            LaunchSubTab:AddFeature(eFeature.Heist.Doomsday.Launch.Reset)

            local MiscSubTab = DoomsdayTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Heist.Doomsday.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Heist.Doomsday.Misc.Teleport.Screen)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Skip)
            MiscSubTab:AddFeature(eFeature.Heist.Doomsday.Misc.Force)
            MiscSubTab:AddFeature(eFeature.Heist.Doomsday.Misc.Finish)
            MiscSubTab:AddFeature(eFeature.Heist.Doomsday.Misc.DataHack)
            MiscSubTab:AddFeature(eFeature.Heist.Doomsday.Misc.DoomsdayHack)

            local CutsSubTab = DoomsdayTab:AddSubTab("分红", "分红")
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Presets)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player1.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player1.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player2.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player2.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player3.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player3.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player4.Toggle)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Player4.Cut)
            CutsSubTab:AddFeature(eFeature.Heist.Doomsday.Cuts.Apply)

            local NonHostTab = DoomsdayTab:AddSubTab("非房主", "非房主")
            NonHostTab:AddFeature(eFeature.Heist.Generic.Cut)
            NonHostTab:AddFeature(eFeature.Heist.Generic.Apply)
        end

        local SalvageYardTab = HeistToolTab:AddSubTab("废品场", "废品场")
        if SalvageYardTab then
            local Slot1SubTab = SalvageYardTab:AddSubTab("槽位1", "槽位1")
            Slot1SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot1.Available)
            Slot1SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot1.Robbery)
            Slot1SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot1.Vehicle)
            Slot1SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot1.Modification)
            Slot1SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot1.Keep)
            Slot1SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot1.Apply)

            local Slot2SubTab = SalvageYardTab:AddSubTab("槽位2", "槽位2")
            Slot2SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot2.Available)
            Slot2SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot2.Robbery)
            Slot2SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot2.Vehicle)
            Slot2SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot2.Modification)
            Slot2SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot2.Keep)
            Slot2SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot2.Apply)

            local Slot3SubTab = SalvageYardTab:AddSubTab("槽位3", "槽位3")
            Slot3SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot3.Available)
            Slot3SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot3.Robbery)
            Slot3SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot3.Vehicle)
            Slot3SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot3.Modification)
            Slot3SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot3.Keep)
            Slot3SubTab:AddFeature(eFeature.Heist.SalvageYard.Slot3.Apply)

            local PrepsSubTab = SalvageYardTab:AddSubTab("前置准备", "前置准备")
            PrepsSubTab:AddFeature(eFeature.Heist.SalvageYard.Preps.Apply)
            PrepsSubTab:AddFeature(eFeature.Heist.SalvageYard.Preps.Complete)
            PrepsSubTab:AddFeature(eFeature.Heist.SalvageYard.Preps.Reset)
            PrepsSubTab:AddFeature(eFeature.Heist.SalvageYard.Preps.Reload)
            PrepsSubTab:AddFeature(eFeature.Heist.SalvageYard.Preps.Free.Setup)
            PrepsSubTab:AddFeature(eFeature.Heist.SalvageYard.Preps.Free.Claim)

            local MiscSubTab = SalvageYardTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Heist.SalvageYard.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Heist.SalvageYard.Misc.Teleport.Board)
            MiscSubTab:AddFeature(eFeature.Heist.Generic.Cutscene)
            MiscSubTab:AddFeature(eFeature.Heist.SalvageYard.Misc.Finish)
            MiscSubTab:AddFeature(eFeature.Heist.SalvageYard.Misc.Sell)
            MiscSubTab:AddFeature(eFeature.Heist.SalvageYard.Misc.Force)
            MiscSubTab:AddFeature(eFeature.Heist.SalvageYard.Misc.Cooldown)

            local PayoutSubTab = SalvageYardTab:AddSubTab("分红", "分红")
            PayoutSubTab:AddFeature(eFeature.Heist.SalvageYard.Payout.Salvage)
            PayoutSubTab:AddFeature(eFeature.Heist.SalvageYard.Payout.Slot1)
            PayoutSubTab:AddFeature(eFeature.Heist.SalvageYard.Payout.Slot2)
            PayoutSubTab:AddFeature(eFeature.Heist.SalvageYard.Payout.Slot3)
            PayoutSubTab:AddFeature(eFeature.Heist.SalvageYard.Payout.Apply)
        end
    end

    local BusinessToolTab = SilentNightTab:AddSubTab("商业工具", "商业工具")
    if BusinessToolTab then
        local BunkerTab = BusinessToolTab:AddSubTab("地堡", "地堡")
        if BunkerTab then
            local SaleSubTab = BunkerTab:AddSubTab("出售", "出售")
            SaleSubTab:AddFeature(eFeature.Business.Bunker.Sale.Price)
            SaleSubTab:AddFeature(eFeature.Business.Bunker.Sale.NoXp)
            SaleSubTab:AddFeature(eFeature.Business.Bunker.Sale.Sell)

            local MiscSubTab = BunkerTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Business.Bunker.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Business.Bunker.Misc.Teleport.Laptop)
            MiscSubTab:AddFeature(eFeature.Business.Bunker.Misc.Open)
            MiscSubTab:AddFeature(eFeature.Business.Bunker.Misc.Supply)
            MiscSubTab:AddFeature(eFeature.Business.Bunker.Misc.Trigger)
            MiscSubTab:AddFeature(eFeature.Business.Bunker.Misc.Supplier)

            local StatsSubTab = BunkerTab:AddSubTab("统计", "统计")
            StatsSubTab:AddFeature(eFeature.Business.Bunker.Stats.SellMade)
            StatsSubTab:AddFeature(eFeature.Business.Bunker.Stats.SellUndertaken)
            StatsSubTab:AddFeature(eFeature.Business.Bunker.Stats.Earnings)
            StatsSubTab:AddFeature(eFeature.Business.Bunker.Stats.NoSell)
            StatsSubTab:AddFeature(eFeature.Business.Bunker.Stats.NoEarnings)
            StatsSubTab:AddFeature(eFeature.Business.Bunker.Stats.Apply)
        end

        local HangarCargoTab = BusinessToolTab:AddSubTab("机库货物", "机库货物")
        if HangarCargoTab then
            local SaleSubTab = HangarCargoTab:AddSubTab("出售", "出售")
            SaleSubTab:AddFeature(eFeature.Business.Hangar.Sale.Price)
            SaleSubTab:AddFeature(eFeature.Business.Hangar.Sale.NoXp)
            SaleSubTab:AddFeature(eFeature.Business.Hangar.Sale.Sell)

            local MiscSubTab = HangarCargoTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Business.Hangar.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Business.Hangar.Misc.Teleport.Laptop)
            MiscSubTab:AddFeature(eFeature.Business.Hangar.Misc.Open)
            MiscSubTab:AddFeature(eFeature.Business.Hangar.Misc.Supply)
            MiscSubTab:AddFeature(eFeature.Business.Hangar.Misc.Supplier)
            MiscSubTab:AddFeature(eFeature.Business.Hangar.Misc.Cooldown)

            local StatsSubTab = HangarCargoTab:AddSubTab("统计", "统计")
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.BuyMade)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.BuyUndertaken)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.SellMade)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.SellUndertaken)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.Earnings)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.NoBuy)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.NoSell)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.NoEarnings)
            StatsSubTab:AddFeature(eFeature.Business.Hangar.Stats.Apply)
        end

        local MoneyFrontsTab = BusinessToolTab:AddSubTab("洗钱据点", "洗钱据点")
        if MoneyFrontsTab then
            local CarWashTab = MoneyFrontsTab:AddSubTab("亲力亲为洗车行")
            CarWashTab:AddFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Teleport.Entrance)
            CarWashTab:AddFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Teleport.Laptop)
            CarWashTab:AddFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Lock)
            CarWashTab:AddFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Max)
            CarWashTab:AddFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Min)
            CarWashTab:AddFeature(eFeature.Business.MoneyFronts.HandsOnCarWash.Heat.Select)

            local WeedShopTab = MoneyFrontsTab:AddSubTab("水上烟雾")
            WeedShopTab:AddFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Teleport.Entrance)
            WeedShopTab:AddFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Teleport.Laptop)
            WeedShopTab:AddFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Lock)
            WeedShopTab:AddFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Max)
            WeedShopTab:AddFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Min)
            WeedShopTab:AddFeature(eFeature.Business.MoneyFronts.SmokeOnTheWater.Heat.Select)

            local TourCompanyTab = MoneyFrontsTab:AddSubTab("希金斯直升机观光")
            TourCompanyTab:AddFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Teleport.Entrance)
            TourCompanyTab:AddFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Teleport.Laptop)
            TourCompanyTab:AddFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Lock)
            TourCompanyTab:AddFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Max)
            TourCompanyTab:AddFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Min)
            TourCompanyTab:AddFeature(eFeature.Business.MoneyFronts.HigginsHelitours.Heat.Select)

            local OverallHeatTab = MoneyFrontsTab:AddSubTab("整体热度")
            OverallHeatTab:AddFeature(eFeature.Business.MoneyFronts.OverallHeat.Lock)
            OverallHeatTab:AddFeature(eFeature.Business.MoneyFronts.OverallHeat.Max)
            OverallHeatTab:AddFeature(eFeature.Business.MoneyFronts.OverallHeat.Min)
            OverallHeatTab:AddFeature(eFeature.Business.MoneyFronts.OverallHeat.Select)
        end

        local NightclubTab = BusinessToolTab:AddSubTab("夜总会", "夜总会")
        if NightclubTab then
            local SaleSubTab = NightclubTab:AddSubTab("出售", "出售")
            SaleSubTab:AddFeature(eFeature.Business.Nightclub.Sale.Price)

            local SafeSubTab = NightclubTab:AddSubTab("保险箱", "保险箱")
            SafeSubTab:AddFeature(eFeature.Business.Nightclub.Safe.Fill)
            SafeSubTab:AddFeature(eFeature.Business.Nightclub.Safe.Collect)
            SafeSubTab:AddFeature(eFeature.Business.Nightclub.Safe.Unbrick)

            local MiscSubTab = NightclubTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Business.Nightclub.Misc.Setup)
            MiscSubTab:AddFeature(eFeature.Business.Nightclub.Misc.Teleport.Entrance)
            MiscSubTab:AddFeature(eFeature.Business.Nightclub.Misc.Teleport.Computer)
            MiscSubTab:AddFeature(eFeature.Business.Nightclub.Misc.Open)
            MiscSubTab:AddFeature(eFeature.Business.Nightclub.Misc.Cooldown)

            local PopularitySubTab = NightclubTab:AddSubTab("人气", "人气")
            PopularitySubTab:AddFeature(eFeature.Business.Nightclub.Popularity.Lock)
            PopularitySubTab:AddFeature(eFeature.Business.Nightclub.Popularity.Max)
            PopularitySubTab:AddFeature(eFeature.Business.Nightclub.Popularity.Min)
            PopularitySubTab:AddFeature(eFeature.Business.Nightclub.Popularity.Select)

            local StatsSubTab = NightclubTab:AddSubTab("统计", "统计")
            StatsSubTab:AddFeature(eFeature.Business.Nightclub.Stats.SellMade)
            StatsSubTab:AddFeature(eFeature.Business.Nightclub.Stats.Earnings)
            StatsSubTab:AddFeature(eFeature.Business.Nightclub.Stats.NoSell)
            StatsSubTab:AddFeature(eFeature.Business.Nightclub.Stats.NoEarnings)
            StatsSubTab:AddFeature(eFeature.Business.Nightclub.Stats.Apply)
        end

        local SpecialCargoTab = BusinessToolTab:AddSubTab("特殊货物", "特殊货物")
        if SpecialCargoTab then
            local SaleSubTab = SpecialCargoTab:AddSubTab("出售", "出售")
            SaleSubTab:AddFeature(eFeature.Business.CrateWarehouse.Sale.Price)
            SaleSubTab:AddFeature(eFeature.Business.CrateWarehouse.Sale.NoXp)
            SaleSubTab:AddFeature(eFeature.Business.CrateWarehouse.Sale.NoCrateback)
            SaleSubTab:AddFeature(eFeature.Business.CrateWarehouse.Sale.Sell)

            local MiscSubTab = SpecialCargoTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Teleport.Office)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Teleport.Computer)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Teleport.Warehouse)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Supply)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Select)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Max)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Buy)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Supplier)
            MiscSubTab:AddFeature(eFeature.Business.CrateWarehouse.Misc.Cooldown)

            local StatsSubTab = SpecialCargoTab:AddSubTab("统计", "统计")
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.BuyMade)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.BuyUndertaken)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.SellMade)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.SellUndertaken)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.Earnings)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.NoBuy)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.NoSell)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.NoEarnings)
            StatsSubTab:AddFeature(eFeature.Business.CrateWarehouse.Stats.Apply)
        end

        local MiscTab = BusinessToolTab:AddSubTab("杂项", "杂项")
        if MiscTab then
            local SuppliesSubTab = MiscTab:AddSubTab("补给", "补给")
            SuppliesSubTab:AddFeature(eFeature.Business.Misc.Supplies.Business)
            SuppliesSubTab:AddFeature(eFeature.Business.Misc.Supplies.Resupply)
            SuppliesSubTab:AddFeature(eFeature.Business.Misc.Supplies.Refresh)

            local GarmentSubTab = MiscTab:AddSubTab("服装工厂", "服装工厂")
            GarmentSubTab:AddFeature(eFeature.Business.Misc.Garment.Teleport.Entrance)
            GarmentSubTab:AddFeature(eFeature.Business.Misc.Garment.Teleport.Computer)
            GarmentSubTab:AddFeature(eFeature.Business.Misc.Garment.Unbrick)
        end
    end

    local MoneyToolTab = SilentNightTab:AddSubTab("金钱工具", "金钱工具")
    if MoneyToolTab then
        local CasinoTab = MoneyToolTab:AddSubTab("赌场", "赌场")
        if CasinoTab then
            local LuckyWheelSubTab = CasinoTab:AddSubTab("幸运轮盘", "幸运轮盘")
            LuckyWheelSubTab:AddFeature(eFeature.Money.Casino.LuckyWheel.Select)
            LuckyWheelSubTab:AddFeature(eFeature.Money.Casino.LuckyWheel.Give)

            local BlackjackSubTab = CasinoTab:AddSubTab("21点", "21点")
            BlackjackSubTab:AddFeature(eFeature.Money.Casino.Blackjack.Card)
            BlackjackSubTab:AddFeature(eFeature.Money.Casino.Blackjack.Reveal)
            BlackjackSubTab:AddFeature(eFeature.Money.Casino.Blackjack.Trick)

            local SlotMachinesSubTab = CasinoTab:AddSubTab("老虎机", "老虎机")
            SlotMachinesSubTab:AddFeature(eFeature.Money.Casino.Slots.Win)
            SlotMachinesSubTab:AddFeature(eFeature.Money.Casino.Slots.Lose)

            local PokerSubTab = CasinoTab:AddSubTab("扑克", "扑克")
            PokerSubTab:AddFeature(eFeature.Money.Casino.Poker.MyCards)
            PokerSubTab:AddFeature(eFeature.Money.Casino.Poker.Cards)
            PokerSubTab:AddFeature(eFeature.Money.Casino.Poker.Reveal)
            PokerSubTab:AddFeature(eFeature.Money.Casino.Poker.Give)
            PokerSubTab:AddFeature(eFeature.Money.Casino.Poker.Trick)

            local RouletteSubTab = CasinoTab:AddSubTab("轮盘赌", "轮盘赌")
            RouletteSubTab:AddFeature(eFeature.Money.Casino.Roulette.Land13)
            RouletteSubTab:AddFeature(eFeature.Money.Casino.Roulette.Land16)

            local MiscSubTab = CasinoTab:AddSubTab("杂项", "杂项")
            MiscSubTab:AddFeature(eFeature.Money.Casino.Misc.Bypass)
            MiscSubTab:AddFeature(eFeature.Money.Casino.Misc.Limit.Select)
            MiscSubTab:AddFeature(eFeature.Money.Casino.Misc.Limit.Acquire)
            MiscSubTab:AddFeature(eFeature.Money.Casino.Misc.Limit.Trade)
        end

        local EasyMoneyTab = MoneyToolTab:AddSubTab("简易刷钱", "简易刷钱")
        if EasyMoneyTab then
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Acknowledge)
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Freeroam._5k)
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Freeroam._50k)
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Freeroam._100k)
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Freeroam._180k)
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Freeroam._680k)
            EasyMoneyTab:AddFeature(eFeature.Money.EasyMoney.Property._300k)
        end

        local MiscTab = MoneyToolTab:AddSubTab("杂项", "杂项")
        if MiscTab then
            local EditSubTab = MiscTab:AddSubTab("编辑", "编辑")
            EditSubTab:AddFeature(eFeature.Money.Misc.Edit.Select)
            EditSubTab:AddFeature(eFeature.Money.Misc.Edit.Deposit)
            EditSubTab:AddFeature(eFeature.Money.Misc.Edit.Withdraw)
            EditSubTab:AddFeature(eFeature.Money.Misc.Edit.Remove)
            EditSubTab:AddFeature(eFeature.Money.Misc.Edit.DepositAll)
            EditSubTab:AddFeature(eFeature.Money.Misc.Edit.WithdrawAll)

            local StorySubTab = MiscTab:AddSubTab("剧情模式", "剧情模式")
            StorySubTab:AddFeature(eFeature.Money.Misc.Story.Select)
            StorySubTab:AddFeature(eFeature.Money.Misc.Story.Character)
            StorySubTab:AddFeature(eFeature.Money.Misc.Story.Apply)

            local StatsSubTab = MiscTab:AddSubTab("统计", "统计")
            StatsSubTab:AddFeature(eFeature.Money.Misc.Stats.Select)
            StatsSubTab:AddFeature(eFeature.Money.Misc.Stats.Earned)
            StatsSubTab:AddFeature(eFeature.Money.Misc.Stats.Spent)
            StatsSubTab:AddFeature(eFeature.Money.Misc.Stats.Apply)
        end
    end

    local DevToolTab = SilentNightTab:AddSubTab("开发工具", "开发工具")
    if DevToolTab then
        local EditorTab = DevToolTab:AddSubTab("编辑器", "编辑器")
        if EditorTab then
            local GlobalsSubTab = EditorTab:AddSubTab("全局变量", "全局变量")
            GlobalsSubTab:AddFeature(eFeature.Dev.Editor.Globals.Type)
            GlobalsSubTab:AddFeature(eFeature.Dev.Editor.Globals.Global)
            GlobalsSubTab:AddFeature(eFeature.Dev.Editor.Globals.Value)
            GlobalsSubTab:AddFeature(eFeature.Dev.Editor.Globals.Read)
            GlobalsSubTab:AddFeature(eFeature.Dev.Editor.Globals.Write)
            GlobalsSubTab:AddFeature(eFeature.Dev.Editor.Globals.Revert)

            local LocalsSubTab = EditorTab:AddSubTab("局部变量", "局部变量")
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Type)
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Script)
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Local)
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Value)
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Read)
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Write)
            LocalsSubTab:AddFeature(eFeature.Dev.Editor.Locals.Revert)

            local StatsSubTab = EditorTab:AddSubTab("统计数据", "统计数据")
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.From)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Type)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Stat)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Value)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Read)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Write)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Revert)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.File)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.WriteAll)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Remove)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Refresh)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Copy)
            StatsSubTab:AddFeature(eFeature.Dev.Editor.Stats.Generate)

            local PackedStatsSubTab = EditorTab:AddSubTab("打包统计数据", "打包统计数据")
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.Range)
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.Type)
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.PackedStat)
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.Value)
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.Read)
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.Write)
            PackedStatsSubTab:AddFeature(eFeature.Dev.Editor.PackedStats.Revert)
        end
    end

    local SettingsTab = SilentNightTab:AddSubTab("设置", "设置")
    if SettingsTab then
        local ConfigSubTab = SettingsTab:AddSubTab("配置和Discord", "配置和Discord")
        ConfigSubTab:AddFeature(eFeature.Settings.Config.Open)
        ConfigSubTab:AddFeature(eFeature.Settings.Config.Logging)
        ConfigSubTab:AddFeature(eFeature.Settings.Config.Reset)
        ConfigSubTab:AddFeature(eFeature.Settings.Config.Copy)
        ConfigSubTab:AddFeature(eFeature.Settings.Config.Discord)
        ConfigSubTab:AddFeature(eFeature.Settings.Config.Unload)

        local TranslationSubTab = SettingsTab:AddSubTab("翻译", "翻译")
        TranslationSubTab:AddFeature(eFeature.Settings.Translation.File)
        TranslationSubTab:AddFeature(eFeature.Settings.Translation.Load)
        TranslationSubTab:AddFeature(eFeature.Settings.Translation.Remove)
        TranslationSubTab:AddFeature(eFeature.Settings.Translation.Refresh)
        TranslationSubTab:AddFeature(eFeature.Settings.Translation.Export)
        TranslationSubTab:AddFeature(eFeature.Settings.Translation.Copy)

        local CollabsSubTab = SettingsTab:AddSubTab("合作插件", "合作插件")
        CollabsSubTab:AddFeature(eFeature.Settings.Collab.JinxScript.Toggle)
        CollabsSubTab:AddFeature(eFeature.Settings.Collab.JinxScript.Discord)
        CollabsSubTab:AddFeature(eFeature.Settings.Collab.JinxScript.Stop)

        local UnlockAllPOISubTab = SettingsTab:AddSubTab("解锁所有兴趣点", "解锁所有兴趣点")
        UnlockAllPOISubTab:AddFeature(eFeature.Settings.UnlockAllPoi.CayoPerico)
        UnlockAllPOISubTab:AddFeature(eFeature.Settings.UnlockAllPoi.DiamondCasino)

        local InstantFinishSubTab = SettingsTab:AddSubTab("立即完成", "立即完成")
        InstantFinishSubTab:AddFeature(eFeature.Settings.InstantFinish.Agency)
        InstantFinishSubTab:AddFeature(eFeature.Settings.InstantFinish.Apartment)
        InstantFinishSubTab:AddFeature(eFeature.Settings.InstantFinish.AutoShop)
        InstantFinishSubTab:AddFeature(eFeature.Settings.InstantFinish.CayoPerico)
        InstantFinishSubTab:AddFeature(eFeature.Settings.InstantFinish.DiamondCasino)
        InstantFinishSubTab:AddFeature(eFeature.Settings.InstantFinish.Doomsday)

        local RegisterAsBossSubTab = SettingsTab:AddSubTab("注册为老板", "注册为老板")
        RegisterAsBossSubTab:AddFeature(eFeature.Settings.RegisterAsBoss.AutoRegister)
        RegisterAsBossSubTab:AddFeature(eFeature.Settings.RegisterAsBoss.Type)

        local EasyMoneySubTab = SettingsTab:AddSubTab("简易刷钱", "简易刷钱")
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.AutoDeposit)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Allow300k)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Prevention)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Delay._5k)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Delay._50k)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Delay._100k)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Delay._180k)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Delay._680k)
        EasyMoneySubTab:AddFeature(eFeature.Settings.EasyMoney.Delay._300k)
    end
end

Renderer.RenderListGUI()

--#endregion
