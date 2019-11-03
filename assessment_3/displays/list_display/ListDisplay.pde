import java.util.List;

class ListDisplay {
    final int maxSize = 10;
    final int xPadding = 50;
    final int yPadding = 50;
    final int rowHeight = (height - yPadding*2)/maxSize;
    List<String> fakeIds;
    ListDisplay() {
        fakeIds = new ArrayList<String>();
    }

    void setup(int uid, String fakeId) {
        fakeIds.add(fakeId);
        while(fakeIds.size() > maxSize) {
            fakeIds.remove(0);
        }
    }

    void draw() {
        int halfRowHeight = rowHeight / 2;
        for(int i = 0; i < fakeIds.size(); i++) {
            stroke(255);
            noFill();
            rect(xPadding, yPadding + i * rowHeight, width - xPadding * 2, rowHeight);
            text(fakeIds.get(i), xPadding * 2, yPadding + (i + 1) * rowHeight - halfRowHeight );
        }
    }
}