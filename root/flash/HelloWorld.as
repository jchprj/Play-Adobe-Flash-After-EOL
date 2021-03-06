// To compile:
// docker run -v ${PWD}:/flash -it --rm jchprj/docker-flex-4.6-sdk-ant mxmlc /flash/HelloWorld.as
package{
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.display.Shape;

    public class HelloWorld extends Sprite
    {
        public function HelloWorld()
        {
            var rectangle:Shape = new Shape;
            rectangle.graphics.beginFill(0x00FFFF);
            rectangle.graphics.drawRect(0, 0, 100,100);
            rectangle.graphics.endFill();
            addChild(rectangle);

            var txtHello: TextField = new TextField();
            txtHello.text = "Hello World";
            addChild(txtHello);
        }
    }
}