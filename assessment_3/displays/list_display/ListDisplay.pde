import java.util.List;

class ListDisplay {
    StateManager stateManager;
    
    String[] table;
    PFont font;
    List<ListDisplayElement> listElements;
    int maxSize = 10;
    ListDisplay() {
        listElements = new ArrayList<ListDisplayElement>();
        table = loadStrings("table.txt");
        font = loadFont("IBMPlexMono-18.vlw");
    }

    void setup() {
         
        
        ListDisplayElement el = new ListDisplayElement(50, 300, 50, font, 16, 200, 255);
        
        listElements.add(el);
        while(listElements.size() > maxSize) {
            listElements.remove(0);
        }
    }

    void draw() {
        int tableY = 50;
        fill(255);
        for (int i = 0; i < table.length; i++) {
            textFont(font, 16);
            text(table[i], 50, tableY);
            tableY+=10;
        }

        for(int i = 0; i < listElements.size(); i++) {
            listElements.get(i).draw(i);
        }
    }

    void addNewListElement() {

        
    }
}