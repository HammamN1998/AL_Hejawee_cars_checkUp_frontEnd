import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CheckupForm1  {

  TextEditingController formNumber = TextEditingController();
  // مقدمة المركبة
  // هيكل امامي ايمن
  TextEditingController c1 = TextEditingController();
  // هيكل امامي ايسر
  TextEditingController c2 = TextEditingController();
  // واجهة امامية
  TextEditingController c3 = TextEditingController();
  // جناح امامي ايمن
  TextEditingController c4 = TextEditingController();
  // جناح امامي ايسر
  TextEditingController c5 = TextEditingController();
  // غطاء المحرك
  TextEditingController c6 = TextEditingController();
  // صدر المركبة
  TextEditingController c7 = TextEditingController();


  // رقم الهيكل
  // طباعة رقم الهيكل
  TextEditingController c8 = TextEditingController();
  // اتصال رقم الهيكل مع جسم المركبة
  TextEditingController c9 = TextEditingController();


  // الحقيبة الخلفية
  // الواجهة الخلفية
  TextEditingController c10 = TextEditingController();
  // ارضية الحقيبة
  TextEditingController c11 = TextEditingController();
  // باب الحقيبة
  TextEditingController c12 = TextEditingController();
  // فخذ خلفي ايمن
  TextEditingController c13 = TextEditingController();
  // فخذ خلفي ايسر
  TextEditingController c14 = TextEditingController();
  // هيكل خلفي ايمن
  TextEditingController c15 = TextEditingController();
  // هيكل خلفي ايسر
  TextEditingController c16 = TextEditingController();


  // ارضية المركبة
  // هيكل امامي ايمن
  TextEditingController c17 = TextEditingController();
  // هيكل امامي ايسر
  TextEditingController c18 = TextEditingController();
  // فخذ امامي ايمن
  TextEditingController c19 = TextEditingController();
  // فخذ امامي ايسر
  TextEditingController c20 = TextEditingController();
  // هيكل خلفي ايمن
  TextEditingController c21 = TextEditingController();
  // هيكل خلفي ايسر
  TextEditingController c22 = TextEditingController();
  // فخذ خلفي ايمن
  TextEditingController c23 = TextEditingController();
  // فخذ خلفي ايسر
  TextEditingController c24 = TextEditingController();
  // اضية المركبة بشكل عام
  TextEditingController c25 = TextEditingController();
  // المرشات السفلية
  TextEditingController c26 = TextEditingController();


  // طلاء المركبة
  // غطاء محرك
  TextEditingController c27_1 = TextEditingController(); // يمين
  TextEditingController c27_2 = TextEditingController(); // يسار
  // جناح امامي
  TextEditingController c28_1 = TextEditingController(); // يمين
  TextEditingController c28_2 = TextEditingController(); // يسار
  // باب امامي
  TextEditingController c29_1 = TextEditingController(); // يمين
  TextEditingController c29_2 = TextEditingController(); // يسار
  // باب خلفي
  TextEditingController c30_1 = TextEditingController(); // يمين
  TextEditingController c30_2 = TextEditingController(); // يسار
  // عمود امامي
  TextEditingController c31_1 = TextEditingController(); // يمين
  TextEditingController c31_2 = TextEditingController(); // يسار
  // عمود وسط
  TextEditingController c32_1 = TextEditingController(); // يمين
  TextEditingController c32_2 = TextEditingController(); // يسار
  // عمود خلفي
  TextEditingController c33_1 = TextEditingController(); // يمين
  TextEditingController c33_2 = TextEditingController(); // يسار
  // جناح خلفي
  TextEditingController c34_1 = TextEditingController(); // يمين
  TextEditingController c34_2 = TextEditingController(); // يسار
  // مرش علوي
  TextEditingController c35_1 = TextEditingController(); // يمين
  TextEditingController c35_2 = TextEditingController(); // يسار
  // مرش سفلي
  TextEditingController c36_1 = TextEditingController(); // يمين
  TextEditingController c36_2 = TextEditingController(); // يسار
  // سقف المركبة
  TextEditingController c37_1 = TextEditingController(); // يمين
  TextEditingController c37_2 = TextEditingController(); // يسار
  // غطاء الحقيبة
  TextEditingController c38_1 = TextEditingController(); // يمين
  TextEditingController c38_2 = TextEditingController(); // يسار


  // التدقيق
  // رقم الهيكل الاساسي
  TextEditingController c39 = TextEditingController();
  // رقم الهيكل اسفل الزجاج
  TextEditingController c40 = TextEditingController();
  // رقم الهيكل على لوحة التعريف
  TextEditingController c41 = TextEditingController();
  // فتحة سقف
  TextEditingController c42 = TextEditingController();
  // عدد المقاعد
  TextEditingController c43 = TextEditingController();
  // وصلة جر
  TextEditingController c44 = TextEditingController();
  // لون المركبة
  TextEditingController c45 = TextEditingController();
  // عداد المركبة
  TextEditingController c46 = TextEditingController();
  // نظام التزحلق ESP
  TextEditingController c47 = TextEditingController();
  // قوة التسيير في المركبة
  TextEditingController c48 = TextEditingController();
  // وجود زفتة في ارضية المركبة
  TextEditingController c49 = TextEditingController();



}
