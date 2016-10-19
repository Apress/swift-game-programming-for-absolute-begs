import SpriteKit

class GridLayout {
    var cellWidth : Int = 0, cellHeight : Int = 0, rows: Int = 0, columns : Int = 0
    var xPadding : Int = 0, yPadding : Int = 0
    var target: SKNode? = nil
    
    init(rows: Int, columns: Int, cellWidth: Int, cellHeight: Int) {
        self.rows = rows
        self.columns = columns
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
    }
    
    var width : CGFloat {
        get { return CGFloat(columns * cellWidth + (columns - 1) * xPadding) }
    }
    
    var height : CGFloat {
        get { return CGFloat(rows * cellHeight + (rows - 1) * yPadding) }
    }
    
    func toPosition(col: Int, row: Int) -> CGPoint {
        let xpos = -width/2 + CGFloat(col * (cellWidth + xPadding) + cellWidth / 2)
        let ypos = -height/2 + CGFloat(row * (cellHeight + yPadding) + cellHeight / 2)
        return CGPoint(x: xpos, y: ypos)
    }
    
    func toGridLocation(position: CGPoint) -> (Int, Int) {
        let colindex = Int(floor((position.x + CGFloat(columns * (cellWidth + xPadding)) / 2) / CGFloat(cellWidth + xPadding)))
        let rowindex = Int(floor((position.y + CGFloat(rows * (cellHeight + yPadding)) / 2) / CGFloat(cellHeight + yPadding)))
        return (colindex, rowindex)
    }
    
    func add(obj: SKNode) {
        if let target_unwrapped = target {
            let r = target_unwrapped.children.count / columns
            let c = target_unwrapped.children.count % columns
            target_unwrapped.addChild(obj)
            obj.position = toPosition(c, row: r)
        }
    }
    
    func at(col: Int, row: Int) -> SKNode? {
        if col < 0 || col >= columns || row < 0 || row >= rows {
            return nil
        }
        if let target_unwrapped = target {
            let index = row * columns + col
            return target_unwrapped.children[index]
        }
        return nil
    }
}