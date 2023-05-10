import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:eportfolio/view/profile.dart';
import '../models/badges_model.dart';
import '../services/api_service.dart';
import '../widgets/custom_appBar.dart';
class AddBadges extends StatefulWidget {
  AddBadges({Key? key, this.id}) : super(key: key);
  String? id;

  @override
  State<AddBadges> createState() => _AddBadgesState(id ?? '');
}

class _AddBadgesState extends State<AddBadges> {
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController imgBadgeController = TextEditingController();
  TextEditingController issuerController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController earnedDateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  List<String> skills = [];
  String? idBadge;
  final _formKey = GlobalKey<FormState>();
  final _formKeyAdd = GlobalKey<FormState>();
  _AddBadgesState(this.idBadge);
  late Future<BadgesModel> futureBadges;

  @override
  void initState() {
    super.initState();
    futureBadges = APIService().fetchSingleBadges(idBadge);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: ProgressHUD(
          color: Colors.black,
          inAsyncCall: isApiCallProcess,
          opacity: 0.6,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: SingleChildScrollView(
              child: FutureBuilder<BadgesModel>(
                future: futureBadges,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    titleController.text = snapshot.data!.title ?? '';
                    imgBadgeController.text = snapshot.data!.imgBadge?? '';
                    issuerController.text = snapshot.data!.issuer ?? '';
                    urlController.text = snapshot.data!.url ?? '';
                    earnedDateController.text = snapshot.data!.earnedDate?? '';
                    descController.text = snapshot.data!.desc ?? '';
                    skillController.text = snapshot.data!.skills.join(',') ?? '';
                    return  Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFF6F6F6),
                          ),
                          child: Form(
                            key : _formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width :250,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter badge image';
                                          }
                                          return null;
                                        },
                                        controller: imgBadgeController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Image Url',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    TextButton( style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue
                                    ),onPressed: (){
                                      Navigator.push(context , MaterialPageRoute(builder: (context) => ProfilePage(5)),
                                      );
                                    }, child: Text(
                                      'Go to Album', style: TextStyle(
                                        color: Colors.white
                                    ),
                                    ))
                                  ],
                                ),
                                SizedBox(height: 15,),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter badge title';
                                    }
                                    return null;
                                  },
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Badges title',
                                    isDense: true,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter badge issuer';
                                    }
                                    return null;
                                  },
                                  controller: issuerController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Issuer',
                                    isDense: true,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter badge url';
                                    }
                                    return null;
                                  },
                                  controller: urlController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Url Learn More',
                                    isDense: true,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 125,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter badge earn date';
                                        }
                                        return null;
                                      },
                                      controller: earnedDateController,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.calendar_today), //icon of text field
                                          labelText: "Earn Date" //label text of field
                                      ),
                                      readOnly: true,
                                      onTap: () async{
                                        DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                                        if(pickedDate != null) {
                                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                          setState(() {
                                            earnedDateController.text = formattedDate;
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter badge description';
                                    }
                                    return null;
                                  },
                                  controller: descController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Description',
                                      isDense :true
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '*',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300, color: Colors.red),
                                        )),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'skills separated by coma (,)',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your skill';
                                    }
                                    return null;
                                  },
                                  controller: skillController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Skills',
                                      isDense :true
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isApiCallProcess = true;
                                          });
                                          List<String> skill = skillController.text.split(',');
                                          if (skill.isNotEmpty) {
                                            for (int i = 0; i < skill.length; i++) {
                                              skills.add(skill[i]);
                                            }
                                          }
                                          APIService().updateBadge(idBadge!, imgBadgeController.text, titleController.text, issuerController.text, urlController.text, earnedDateController.text, descController.text, skills)
                                              .then((response) {
                                            if (response) {
                                              FormHelper.showSimpleAlertDialog(
                                                context,
                                                "Success!",
                                                "Success update badge!",
                                                "OK",
                                                    () {
                                                  Navigator.pushNamed(context, '/badge');
                                                },
                                              );
                                            } else {
                                              FormHelper.showSimpleAlertDialog(
                                                context,
                                                "Error!",
                                                "Failed update badge! Please try again",
                                                "OK",
                                                    () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    isApiCallProcess = false;
                                                  });
                                                },
                                              );
                                            }
                                          });
                                        }
                                      },
                                      child: Text(
                                        'Update badges',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else return
                    Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFF6F6F6),
                        ),
                        child: Form(
                          key: _formKeyAdd,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width :250,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter badge image';
                                        }
                                        return null;
                                      },
                                      controller: imgBadgeController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Image Url',
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  TextButton( style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue
                                  ),onPressed: (){
                                    Navigator.push(context , MaterialPageRoute(builder: (context) => ProfilePage(5)),
                                    );
                                  }, child: Text(
                                    'Go to Album', style: TextStyle(
                                      color: Colors.white
                                  ),
                                  ))
                                ],
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter badge title';
                                  }
                                  return null;
                                },
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Badges title',
                                  isDense: true,
                                ),
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter badge issuer';
                                  }
                                  return null;
                                },
                                controller: issuerController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Issuer',
                                  isDense: true,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter badge url';
                                  }
                                  return null;
                                },
                                controller: urlController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Url Learn More',
                                  isDense: true,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 125,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter badge earn date';
                                      }
                                      return null;
                                    },
                                    controller: earnedDateController,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today), //icon of text field
                                        labelText: "Earn Date" //label text of field
                                    ),
                                    readOnly: true,
                                    onTap: () async{
                                      DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                                      if(pickedDate != null) {
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                        setState(() {
                                          earnedDateController.text = formattedDate;
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter badge description';
                                  }
                                  return null;
                                },
                                controller: descController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Description',
                                    isDense :true
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '*',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300, color: Colors.red),
                                      )),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'skills separated by coma (,)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )),
                                ],
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your skill';
                                  }
                                  return null;
                                },
                                controller: skillController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Skills',
                                    isDense :true
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue
                                    ),
                                    onPressed: () {
                                      if (_formKeyAdd.currentState!.validate()) {
                                        setState(() {
                                          isApiCallProcess = true;
                                        });
                                        List<String> skill = skillController.text.split(',');
                                        if (skill.isNotEmpty) {
                                          for (int i = 0; i < skill.length; i++) {
                                            skills.add(skill[i]);
                                          }
                                        }
                                        APIService().createBadge(imgBadgeController.text, titleController.text, issuerController.text, urlController.text, earnedDateController.text, descController.text, skills)
                                            .then((response) {
                                          if (response) {
                                            FormHelper.showSimpleAlertDialog(
                                              context,
                                              "Success!",
                                              "Success create badge!",
                                              "OK",
                                                  () {
                                                Navigator.pushNamed(context, '/badge');
                                              },
                                            );
                                          } else {
                                            FormHelper.showSimpleAlertDialog(
                                              context,
                                              "Error!",
                                              "Failed create badge! Please try again",
                                              "OK",
                                                  () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isApiCallProcess = false;
                                                });
                                              },
                                            );
                                          }
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Add badges',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
