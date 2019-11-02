import java.util.Arrays;
import java.util.List;

import oscP5.*;

PVector[][] features = {
	{
		new PVector(172.973, 216.573),
		new PVector(180.438, 212.994),
		new PVector(189.012, 213.277),
		new PVector(196.711, 216.161),
	},
	{
		new PVector(247.247, 217.378),
		new PVector(255.447, 214.366),
		new PVector(264.464, 215.362),
		new PVector(272.456, 219.341),
	},
	{
		new PVector(160.456, 190.877),
		new PVector(169.024, 183.201),
		new PVector(179.743, 180.384),
		new PVector(190.659, 180.993),
		new PVector(200.803, 184.091),
	},
	{
		new PVector(239.469, 184.125),
		new PVector(254.244, 181.191),
		new PVector(269.342, 181.642),
		new PVector(283.515, 187.349),
		new PVector(294.273, 198.521),
	},
	{
		new PVector(172.973, 216.573),
		new PVector(180.438, 212.994),
		new PVector(189.012, 213.277),
		new PVector(196.711, 216.161),
		new PVector(188.864, 218.61),
		new PVector(180.586, 218.921),
	},
	{
		new PVector(247.247, 217.378),
		new PVector(255.447, 214.366),
		new PVector(264.464, 215.362),
		new PVector(272.456, 219.341),
		new PVector(264.092, 221.01),
		new PVector(255.299, 220.306),
	},
	{
		new PVector(148.722, 226.08),
		new PVector(145.94, 247.269),
		new PVector(144.959, 268.674),
		new PVector(145.226, 289.062),
		new PVector(148.168, 308.349),
		new PVector(156.501, 325.313),
		new PVector(171.138, 338.341),
		new PVector(189.429, 347.332),
		new PVector(209.997, 350.262),
	},
	{
		new PVector(209.997, 350.262),
		new PVector(235.006, 351.803),
		new PVector(259.716, 348.29),
		new PVector(282.818, 340.176),
		new PVector(300.841, 325.679),
		new PVector(310.976, 305.173),
		new PVector(316.669, 281.271),
		new PVector(319.88, 255.894),
		new PVector(322.124, 230.515),
	},
	{
		new PVector(148.722, 226.08),
		new PVector(145.94, 247.269),
		new PVector(144.959, 268.674),
		new PVector(145.226, 289.062),
		new PVector(148.168, 308.349),
		new PVector(156.501, 325.313),
		new PVector(171.138, 338.341),
		new PVector(189.429, 347.332),
		new PVector(209.997, 350.262),
		new PVector(235.006, 351.803),
		new PVector(259.716, 348.29),
		new PVector(282.818, 340.176),
		new PVector(300.841, 325.679),
		new PVector(310.976, 305.173),
		new PVector(316.669, 281.271),
		new PVector(319.88, 255.894),
		new PVector(322.124, 230.515),
	},
	{
		new PVector(185.785, 294.669),
		new PVector(193.352, 286.588),
		new PVector(202.278, 280.625),
		new PVector(212.08, 281.312),
		new PVector(224.065, 281.449),
		new PVector(234.939, 288.39),
		new PVector(245.342, 296.589),
		new PVector(234.619, 300.676),
		new PVector(222.964, 302.043),
		new PVector(211.362, 301.549),
		new PVector(201.865, 301.498),
		new PVector(192.905, 299.556),
	},
	{
		new PVector(185.785, 294.669),
		new PVector(201.857, 290.901),
		new PVector(211.8, 290.136),
		new PVector(224.331, 291.473),
		new PVector(245.342, 296.589),
		new PVector(224.181, 292.023),
		new PVector(211.744, 290.61),
		new PVector(201.855, 291.354),
	},
	{
		new PVector(216.372, 208.94),
		new PVector(214.538, 219.339),
		new PVector(212.642, 229.554),
		new PVector(210.739, 239.685),
	},
	{
		new PVector(200.68, 258.08),
		new PVector(206.032, 259.167),
		new PVector(211.576, 259.429),
		new PVector(219.248, 259.587),
		new PVector(226.865, 258.964),
	},
	{
		new PVector(160.456, 190.877),
		new PVector(169.024, 183.201),
		new PVector(179.743, 180.384),
		new PVector(190.659, 180.993),
		new PVector(200.803, 184.091),
		new PVector(239.469, 184.125),
		new PVector(254.244, 181.191),
		new PVector(269.342, 181.642),
		new PVector(283.515, 187.349),
		new PVector(294.273, 198.521),
		new PVector(322.124, 230.515),
		new PVector(319.88, 255.894),
		new PVector(316.669, 281.271),
		new PVector(310.976, 305.173),
		new PVector(300.841, 325.679),
		new PVector(282.818, 340.176),
		new PVector(259.716, 348.29),
		new PVector(235.006, 351.803),
		new PVector(209.997, 350.262),
		new PVector(189.429, 347.332),
		new PVector(171.138, 338.341),
		new PVector(156.501, 325.313),
		new PVector(148.168, 308.349),
		new PVector(145.226, 289.062),
		new PVector(144.959, 268.674),
		new PVector(145.94, 247.269),
		new PVector(148.722, 226.08),
	},
};

String host;
int serverPort;

GenderDisplay genderDisplay;

OscP5 oscP5;

void setup() {
  size(400,400);
  genderDisplay = new GenderDisplay();
  //host = System.getenv("GENDER_DISPLAY_SERVER_ADDR");
  //serverPort = Integer.parseInt(System.getenv("GENDER_DISPLAY_SERVER_PORT"));

  List<List<PVector>> featuresList = new ArrayList<List<PVector>>();
  for (PVector[] array : features) {
      featuresList.add(Arrays.asList(array));
  }
  genderDisplay.setup(20, true, featuresList);
 
  host = "localhost";
  serverPort = 8012;
  println("Hosting on " + host + ":" + serverPort);
  frameRate(25);
  oscP5 = new OscP5(this, serverPort);
}

void draw() {
  background(0);
  genderDisplay.draw();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage message) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+message.addrPattern());
  println(" typetag: "+message.typetag());

  int uid = message.get(0).intValue();
  println(" uid: "+uid);
  boolean isMale = message.typetag().charAt(1) == 'T';

  List<List<PVector>> points = new ArrayList<List<PVector>>();
  for(int i = 0; i < 14; i++) {
    String blob = message.get(i+2).stringValue();
    points.add(new ArrayList<PVector>()); //<>//
    String[] items = blob.split("\\s*,\\s*");
    for(int j = 0; j < items.length; j+=2) {
      PVector vec = new PVector(Integer.parseInt(items[j]), Integer.parseInt(items[j+1])); //<>//
      points.get(i).add(vec); //<>//
    }
  }
  genderDisplay.setup(uid, isMale, points);
}
