import java.util.List;

class ListDisplay {
    StateManager stateManager;
    
    PFont font;
    List<ListDisplayElement> listElements;
    int maxSize = 10;
    ListDisplay() {
        listElements = new ArrayList<ListDisplayElement>();
    }

    void setup() {
        font = loadFont("IBMPlexMono-18.vlw");
        ListDisplayElement el = new ListDisplayElement(50, 300, 50, font, 12, 200, 255);

        listElements.add(el);
        while(listElements.size() > maxSize) {
            listElements.remove(0);
        }
    }

    void draw() {
        for(int i = 0; i < listElements.size(); i++) {
            listElements.get(i).draw(i);
        }
    }

    void addNewListElement() {

        
    }
}