import 'package:ussd_advanced/ussd_advanced.dart';

class SendMoneyResponse {
  final bool successful;
  final String? name;
  final String? refID;

  SendMoneyResponse(this.successful, {this.name, this.refID});
}

class UPIService {
  bool log = false;
  late int digits;
  bool digitsInitialised = false;

  UPIService({bool? logging}) {
    if (logging ?? false) {
      log = true;
    } else {
      log = false;
    }
    () async {
      print("initialising digits");
      digits = (await determineDigitsInPin()) ?? 6;
      print("Digits "+digits.toString());
      digitsInitialised = true;
    } ();
  }

  void logIfNeeds(String message) {
    if (log) {
      print("UPI USSD log: $message");
    }
  }

  Future<void> checkDigitsInitialised() async {
    while (true) {
      if (digitsInitialised) {
        break;
      }
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  Future<void> clearRequests() async {
    try {
      await UssdAdvanced.cancelSession();
    } catch (e) {
      logIfNeeds("could not handle cancelling session");
    }
  }

  /* Future<SendMoneyResponse> sendMoneyToNumber(String number, String amount, String pin, {String remark = '1'}) async {
    await clearRequests();
    String? req = await UssdAdvanced.multisessionUssd(code: "*99*1*1*$number*$amount*$remark#", subscriptionId: 1);
    logIfNeeds(req ?? "No Result");
    if (req == null) {
      return SendMoneyResponse(false);
    }


    if (req.contains("You are paying to")) {
      await Future.delayed(Duration(milliseconds: 10));
      String? output = await UssdAdvanced.sendMessage(pin);
      logIfNeeds(output ?? "No Result");

      if (output == null) {
        return SendMoneyResponse(false);
      }


      if (output.contains("is successful")) {
        String refid = output.split("(RefId: ")[1].split(")")[0];
        String name = output.split("Your payment to ")[1].split(",")[0];
        return SendMoneyResponse(true, name: name, refID: refid);
      } else {
        throw Exception("Some error occurred");
      }
    } else if (req.contains("is not a valid")) {
      throw Exception("Invalid number");
    } else {
      throw Exception("Some error occurred");
    }
  } */

  Future<SendMoneyResponse> sendMoneyToUpiId(String id, num amount, String pin, {String remark = '1'}) async {
    print("transferred control");
    //await checkDigitsInitialised();
    print("digits are initialised");
    await clearRequests();
    
    String? req = await UssdAdvanced.multisessionUssd(code: "*99*1*3#", subscriptionId: 1);
    logIfNeeds(req ?? "No Result");
    print("ussd request sent");

    if (req == null) {
      return SendMoneyResponse(false);
    }

    if (req.contains("Enter UPI")) {
      await Future.delayed(Duration(milliseconds: 10));
      req = await UssdAdvanced.sendMessage(id);
      logIfNeeds(req ?? "No Result");

      if (req == null) {
        return SendMoneyResponse(false);
      }

      if (req.contains("TRANSACTION DECLINED")) {
        throw Exception("Invalid UPI ID or UPI ID does not exist");
      } else if (req.contains("Paying")) {
        String name = req.split("Paying ")[1].split(",")[0];
        await Future.delayed(Duration(milliseconds: 10));
        req = await UssdAdvanced.sendMessage(amount.toString());
        logIfNeeds(req ?? "No Result");

        if (req == null) {
        return SendMoneyResponse(false);
        }

        if (req.contains("Enter a remark")) {
          await Future.delayed(Duration(milliseconds: 10));
          req = await UssdAdvanced.sendMessage(remark);
          logIfNeeds(req ?? "No Result");

          if (req == null) {
        return SendMoneyResponse(false);
        }

          if (req.contains("You are paying to")) {
            await Future.delayed(Duration(milliseconds: 10));
            String? output = await UssdAdvanced.sendMessage(pin);
            logIfNeeds(output ?? "No Result");

            if (output == null) {
        return SendMoneyResponse(false);
        }

            if (output.contains("is successful")) {
              String refid = output.split("(RefId: ")[1].split(")")[0];
              return SendMoneyResponse(true, name: name, refID: refid);
            } else {
              throw Exception("Some error occurred");
            }
          } else {
            throw Exception("Some error occurred");
          }
        } else if (req.contains("not a valid")) {
          throw Exception("Invalid amount");
        } else {
          throw Exception("Some error occurred");
        }
      } else {
        throw Exception("Some error occurred");
      }
    } else {
      throw Exception("Some error occurred");
    }
  }

  /* Future<String> checkBalance(String pin) async {
    await clearRequests();
    String req = await UssdAdvanced.sendUssd("*99*3#", subscriptionId: 1);
    logIfNeeds(req);

    if (req.contains("Enter")) {
      await Future.delayed(Duration(milliseconds: 10));
      String output = await UssdAdvanced.sendUssd(pin, subscriptionId: 1);
      logIfNeeds(output);

      if (output.contains("Incorrect UPI")) {
        throw Exception("Incorrect UPI PIN");
      } else if (output.contains("Your account balance is")) {
        return output.split("Your account balance is Rs. ")[1].split("\n")[0];
      } else if (output.contains("Error fetching balance")) {
        throw Exception("Error fetching balance");
      } else {
        throw Exception("Some error occurred");
      }
    } else {
      throw Exception("Some error occurred");
    }
  } */

  Future<int?> determineDigitsInPin() async {
    await clearRequests();
    String? req = await UssdAdvanced.sendAdvancedUssd(code: "*99*3#", subscriptionId: 1);
    logIfNeeds(req ?? "No Result");

    if (req == null ) {
      return null;
    }

    if (req.contains("Enter")) {
      return int.parse(req.split("Enter ")[1].split(" digit")[0]);
    } else {
      throw Exception("Some error occurred");
    }
  }
}


class DummyUPIService {
  final bool log;
  final digits = 4;

  DummyUPIService({this.log = true});

  void logIfNeeds(String message) {
    if (log) {
      print("UPI Dummy log: $message");
    }
  }

  Future<void> clearRequests() async {
    logIfNeeds("Dummy clearRequests called");
    // Simulate a delay for the operation
    await Future.delayed(Duration(milliseconds: 2));
  }

  Future<SendMoneyResponse> sendMoneyToUpiId(String id, num amount, String pin, {String remark = '1'}) async {
    await clearRequests();
    logIfNeeds("Dummy sendMoneyToUpiId called with ID: $id, Amount: $amount, Pin: $pin, Remark: $remark");

    // Simulate a delay for the operation
    await Future.delayed(Duration(milliseconds: 1000));

    // Return a dummy successful response
    return SendMoneyResponse(true, name: "Dummy Name", refID: "DUMMY_REF1234");
  }

  Future<String> checkBalance(String pin) async {
    await clearRequests();
    logIfNeeds("Dummy checkBalance called with Pin: $pin");

    // Simulate a delay for the operation
    await Future.delayed(Duration(milliseconds: 1000));

    // Return a dummy balance
    return "1000.00";
  }

  }
