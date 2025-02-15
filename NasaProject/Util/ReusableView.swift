//
//  ReusableView.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String {get}
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {

    func register<T: UICollectionViewCell>(type: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, of type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    func cellForItem<T: UICollectionViewCell>(at: IndexPath) -> T {
        guard let cell = self.cellForItem(at: at) as? T else {
            fatalError("Could not find cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UITableViewCell: ReusableView {}

extension UITableView {

    func register<T: UITableViewCell>(type: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, of type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

}
