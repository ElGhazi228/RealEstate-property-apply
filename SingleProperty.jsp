%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="DTO.PropertyDTOV2"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


                  <!--like feature-->
                  <div class="pr-single-info">
                                <%StarredPropertyDBHandler sdb = new StarredPropertyDBHandler(); %>
                                <% if (sdb.isALreadyStarred(new StarredPropertyDTO(student_id, proObj.getId()))) {%>
                                <a class="like-bitt add-to-favorite" onclick="likeProperty(this)" data-target-id="<%= proObj.getId()%>"  data-target-star="1" data-original-title="Add To Favorites"><i class="lni-heart-filled"></i></a>
                                    <%} else {%>
                                <a class="like-bitt add-to-favorite" onclick="likeProperty(this)" data-target-id="<%= proObj.getId()%>"  data-target-star="0" data-original-title="Add To Favorites"><i class="lni-heart"></i></a>
                                    <%}%>
                            </div>



                    <!-- Agent Detail -->
                    <%AgencyDBHandler agencydb = new AgencyDBHandler();
                        AgencyDTO agency = agencydb.getAgencyByID(proObj.getAgency_id());
                    %>
                    <div class="">
                        <div class="">
                            <div class="agent-photo"><img src="<%= agency.getProfile_pic()%>" alt=""></div>
                            <div class="agent-details">
                                <h4><a href="AgencyProfile.jsp?id=<%=agency.getId()%>"><%= agency.getName()%></a></h4>
                                    <%AppliedPropertyDBHandler adb = new AppliedPropertyDBHandler();%>
                                <span><i class=""></i><%=agency.getContact()%></span>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <%
                            if (!adb.isALreadyApplied(new AppliedPropertyDTO(tenant_id, proObj.getId()))) {%>
                        <button class="btn btn-theme"  id="applybtn" onclick="applyPropertty(this)" data-target-applyid="<%=proObj.getId()%>" data-target-apply="0" >Interested</button>
                        <%} else {%>
                        <button class="btn btn-theme"  id="applybtn" onclick="applyPropertty(this)"data-target-applyid="<%=proObj.getId()%>" data-target-apply="1" >Uninterested</button>
                        <%}%>
                    </div>           
                              <%}%>
                            </div>
                                               
                        </div>
                          
                    </div>

                </div>
            </div>
            </section>
         

           
            
            <script>function applyPropertty(d)
                                                {
                                                    var $id = $(d).attr("data-target-applyid");
                                                    var obj = {
                                                        "property_id": $id,
                                                    };
                                                    
                                                    
                                                    if ($(d).attr("data-target-apply") == "0") {
                                                        $.ajax({
                                                            type: "post",
                                                            url: "AppliedProperty",
                                                            //cache: false,
                                                            data: JSON.stringify(obj),
                                                            success: function (result) {
                                                                if (result == 1)
                                                                {
                                                                    // $($(d).text(Un Apply));
                                                                    $(d).attr("data-target-apply", "1");
                                                                    alert("Property Applied");
                                                                    $("#applybtn").text("Un Apply");
                                                                } else if (result == 2)
                                                                {
                                                                    alert("Property Already Applied");
                                                                } else
                                                                {
                                                                    alert("Can not process request");
                                                                }
                                                            },
                                                            error: function () {
                                                                alert("Can not process request");
                                                            }
                                                        });
                                                    } else {
                                                        // ajax
                                                        $.ajax({
                                                            type: "post",
                                                            url: "UnAppliedProperty",
                                                            //cache: false,
                                                            data: JSON.stringify(obj),
                                                            success: function (result) {
                                                                if (result == 1)
                                                                {
                                                                    // $($(d).text(Apply));
                                                                    $(d).attr("data-target-apply", "0");
                                                                    alert("Property Un Applied");
                                                                    $("#applybtn").text("Apply");
                                                                } else if (result == 2)
                                                                {
                                                                    alert("Property Already Un Applied");
                                                                } else
                                                                {
                                                                    alert("Can not process request");
                                                                }
                                                            },
                                                            error: function () {
                                                                alert("can't  procced request");
                                                            }
                                                        });
                                                    }
                                                }
                                                function likeProperty(d) {
                                                    var $id = $(d).attr("data-target-id");
                                                    var obj = {
                                                        "property_id": $id,
                                                    };
                                                    if ($(d).attr("data-target-star") == "0") {
                                                        $.ajax({
                                                            type: "post",
                                                            url: "StarredProperty",
                                                            //cache: false,
                                                            data: JSON.stringify(obj),
                                                            success: function (result) {
                                                                if (result == 1)
                                                                {
                                                                    $($(d).children("i")[0]).toggleClass("lni-heart lni-heart-filled");
                                                                    $(d).attr("data-target-star", "1");
                                                                    alert("Property Liked");
                                                                } else if (result == 2)
                                                                {
                                                                    alert("Propert Already Liked");
                                                                } else
                                                                {
                                                                    alert("Can not process request");
                                                                }
                                                            },
                                                            error: function () {
                                                                alert("Can not process request");
                                                            }
                                                        });
                                                    } else {
                                                        // ajax
                                                        $.ajax({
                                                            type: "post",
                                                            url: "UnStarredProperty",
                                                            //cache: false,
                                                            data: JSON.stringify(obj),
                                                            success: function (result) {
                                                                if (result == 1)
                                                                {
                                                                    $($(d).children("i")[0]).toggleClass("lni-heart lni-heart-filled");
                                                                    $(d).attr("data-target-star", "0");
                                                                    alert("Property UnLiked");
                                                                } else if (result == 2)
                                                                {
                                                                    alert("Property Already UnLiked");
                                                                } else
                                                                {
                                                                    alert("catn not procced request");
                                                                }
                                                            },
                                                            error: function () {
                                                                alert("can't  procced request");
                                                            }
                                                        });
                                                    }
                                                }
            </script>


            </body>
            
            </html>
